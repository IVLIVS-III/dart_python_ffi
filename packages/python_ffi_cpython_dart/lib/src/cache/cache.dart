part of python_ffi_cpython_dart;

abstract base class _Cache {
  _Cache({required this.version, required this.cacheDir});

  final String version;
  final Directory cacheDir;
  final Logger logger = Logger.standard();
  final int uuid = Random().nextDouble().hashCode % 256;

  _DownloadEntry? get _entry;

  String get _loggerFileIdentifier;

  File _cacheFile(_DownloadEntry entry, Directory cacheDir) =>
      File("${cacheDir.path}/${entry.filename}");

  File _cacheFileLock(_DownloadEntry entry, Directory cacheDir) =>
      File("${cacheDir.path}/${entry.filename}.lock");

  Future<bool> _lock(_DownloadEntry entry) async {
    final File cacheFileLock = _cacheFileLock(entry, cacheDir);
    // try to get the lock
    Progress? progress;
    while (cacheFileLock.existsSync()) {
      final int? id = (await cacheFileLock.readAsBytes()).singleOrNull;
      if (id == uuid) {
        // we hold the lock
        progress?.finish(showTiming: true);
        break;
      }
      if (id == null) {
        // weird state, delete the lock and try again
        await cacheFileLock.delete();
        continue;
      }

      // someone else holds the lock, wait for them to finish
      progress ??= logger.progress(
        "Waiting for another command to release the $_loggerFileIdentifier lock",
      );
      final Completer<void> completer = Completer<void>();
      final Timer timeout =
          Timer(const Duration(seconds: 10), completer.complete);
      late final StreamSubscription<FileSystemEvent> streamSubscription =
          cacheFileLock
              .watch(events: FileSystemEvent.delete)
              .listen((_) => completer.complete());
      await completer.future;
      timeout.cancel();
      await streamSubscription.cancel();
    }
    // create the lock
    cacheFileLock
      ..createSync(recursive: true)
      ..writeAsBytesSync(<int>[uuid]);
    logger.trace("Acquired $_loggerFileIdentifier lock: $uuid");
    return true;
  }

  Future<void> _unlock(_DownloadEntry entry) async {
    final File cacheFileLock = _cacheFileLock(entry, cacheDir);
    if (cacheFileLock.existsSync()) {
      final int? id = (await cacheFileLock.readAsBytes()).singleOrNull;
      if (id == uuid) {
        await cacheFileLock.delete();
        logger.trace("Released $_loggerFileIdentifier lock: $uuid");
      }
    }
  }

  Future<bool> _exists(_DownloadEntry entry) async {
    final File cacheFile = _cacheFile(entry, cacheDir);
    if (!cacheFile.existsSync()) {
      return false;
    }
    final Uint8List bytes = await cacheFile.readAsBytes();
    final crypto.Digest digest = crypto.sha256.convert(bytes);
    return digest.toString().toLowerCase() == entry.sha256.toLowerCase();
  }

  Future<bool> _get(_DownloadEntry entry) async {
    // setup download client
    final HttpClient client = HttpClient();
    // set user agent
    final StringBuffer userAgent = StringBuffer();
    final String? previousUserAgent = client.userAgent;
    if (previousUserAgent != null) {
      userAgent
        ..write(previousUserAgent)
        ..write("; ");
    }
    userAgent.write("Dart Python FFI");
    client.userAgent = userAgent.toString();
    // download the resource
    final Progress downloadProgress =
        logger.progress("Downloading $_loggerFileIdentifier");
    final HttpClientRequest request = await client.getUrl(Uri.parse(entry.url));
    final HttpClientResponse response = await request.close();
    if (response.statusCode != 200) {
      logger.stderr(
        "Failed to download $_loggerFileIdentifier: ${response.statusCode} ${response.reasonPhrase}",
      );
      return false;
    }
    final File cacheFile = _cacheFile(entry, cacheDir);
    if (cacheFile.existsSync()) {
      await cacheFile.delete(recursive: true);
    }
    await cacheFile.create(recursive: true);
    final RandomAccessFile fileHandle =
        cacheFile.openSync(mode: FileMode.append)..lockSync();
    await for (final List<int> chunk in response) {
      await fileHandle.writeFrom(chunk);
    }
    fileHandle
      ..unlockSync()
      ..closeSync();
    downloadProgress.finish(showTiming: true);
    logger.trace("$_loggerFileIdentifier written to '${cacheFile.path}'");
    final bool success = await _exists(entry);
    if (!success) {
      logger.stderr("$_loggerFileIdentifier download failed");
      await cacheFile.delete(recursive: true);
    }
    return success;
  }

  Future<bool> ensure() async {
    final _DownloadEntry? entry = _entry;
    if (entry == null) {
      return false;
    }
    await _lock(entry);
    if (await _exists(entry)) {
      await _unlock(entry);
      return true;
    }
    final bool result = await _get(entry);
    await _unlock(entry);
    return result;
  }
}
