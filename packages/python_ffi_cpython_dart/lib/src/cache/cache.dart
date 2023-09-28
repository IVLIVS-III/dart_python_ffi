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
      File(p.join(cacheDir.path, entry.filename));

  File _cacheFileLock(_DownloadEntry entry, Directory cacheDir) =>
      File(p.join(cacheDir.path, "${entry.filename}.lock"));

  Future<RandomAccessFile> _lockThreadSafe(_DownloadEntry entry) async {
    final File cacheFileLock = _cacheFileLock(entry, cacheDir);
    // try to get the lock
    final Progress progress = logger.progress(
      "Waiting for another command to release the $_loggerFileIdentifier lock",
    );
    const Duration sleep = Duration(milliseconds: 100);
    while (true) {
      try {
        if (!cacheFileLock.existsSync()) {
          cacheFileLock.createSync(recursive: true);
        }
        final RandomAccessFile file =
            cacheFileLock.openSync(mode: FileMode.write);
        await file.lock(FileLock.blockingExclusive);
        progress.finish(showTiming: true);
        logger.trace("Acquired $_loggerFileIdentifier lock: $uuid");
        return file;
      } on FileSystemException catch (e) {
        logger.trace("Failed to acquire $_loggerFileIdentifier lock: $e");
        await Future<void>.delayed(sleep);
      }
    }
  }

  Future<bool> _unlockThreadSafe(RandomAccessFile lockFile) async {
    try {
      await lockFile.unlock();
      await lockFile.close();
      return true;
    } on FileSystemException catch (e) {
      logger.trace("Failed to release $_loggerFileIdentifier lock: $e");
      return false;
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

  /// Executes [callback] at most [maxRetries] + 1 times, retrying on
  /// [Exception]s.
  /// Returns the result of [callback] and an [Iterable] of [Exception]s that
  /// were thrown. At most [maxRetries] + 1 [Exception]s are returned, exactly
  /// one for each time [callback] was called unsuccessfully.
  /// If [exceptionalReturn] is not null and [maxRetries] retries were
  /// unsuccessful, [exceptionalReturn] is returned instead of throwing the last
  /// [Exception]. Hence, it is advised to provide [exceptionalReturn].
  /// Otherwise all [Exception]s but the last one are swallowed silently in case
  /// of exhaustion of [maxRetries].
  /// Waits for [backoff] between retries, doubles [backoff] after each retry.
  static Future<(T, Iterable<E>)> exceptionalRetry<T, E extends Exception>(
    FutureOr<T> Function() callback, {
    int maxRetries = 7,
    Duration backoff = const Duration(milliseconds: 100),
    T? exceptionalReturn,
  }) async {
    try {
      final T result = await callback();
      return (result, <E>[]);
    } on E catch (e) {
      if (maxRetries == 0) {
        if (exceptionalReturn != null) {
          return (exceptionalReturn, <E>[e]);
        }
        rethrow;
      }
      await Future<void>.delayed(backoff);
      final (T result, Iterable<E> errors) = await exceptionalRetry(
        callback,
        maxRetries: maxRetries - 1,
        backoff: backoff * 2,
      );
      return (result, errors.add(e));
    }
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
    final Uint8List bytes = Uint8List(response.contentLength);
    int offset = 0;
    await for (final List<int> chunk in response) {
      bytes.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }
    await exceptionalRetry<void, OSError>(
      () async {
        if (cacheFile.existsSync()) {
          await cacheFile.delete(recursive: true);
        }
        await cacheFile.create(recursive: true);
        final RandomAccessFile fileHandle =
            cacheFile.openSync(mode: FileMode.write)..lockSync();
        await fileHandle.writeFrom(bytes);
        fileHandle
          ..unlockSync()
          ..closeSync();
      },
      backoff: const Duration(seconds: 1),
    );
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
    final RandomAccessFile lockFile = await _lockThreadSafe(entry);
    if (await _exists(entry)) {
      await _unlockThreadSafe(lockFile);
      return true;
    }
    final bool result = await _get(entry);
    await _unlockThreadSafe(lockFile);
    return result;
  }
}
