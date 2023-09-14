part of python_ffi_cpython_dart;

extension on DateTime {
  Uint8List get bytes {
    final int now = millisecondsSinceEpoch;
    return Uint8List.fromList(
      List<int>.generate(8, (int i) => now >> ((8 - i) * 8) & 0xff),
    );
  }
}

extension on Iterable<int> {
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(
        take(8).fold(0, (int a, int b) => a << 8 | b),
      );
}

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

  Future<void> _tryDeleteCacheFileLock(File cacheFileLock) async {
    try {
      await cacheFileLock.delete();
    } on PathNotFoundException catch (e) {
      logger.trace("Failed to delete $_loggerFileIdentifier lock: $e");
    }
  }

  /// Lock file format:
  /// - 1 byte: uuid of the process that holds the lock
  /// - 8 bytes: timestamp of when the lock was acquired
  ///            - must be updated every 10 seconds
  ///            - if the timestamp is older than 30 seconds, the lock is
  ///              considered stale and can be deleted
  Future<bool> _lock(_DownloadEntry entry) async {
    final File cacheFileLock = _cacheFileLock(entry, cacheDir);
    // try to get the lock
    Progress? progress;
    while (cacheFileLock.existsSync()) {
      final DateTime now = DateTime.now();
      final Uint8List bytes = await cacheFileLock.readAsBytes();
      final int? id = bytes.firstOrNull;
      if (id == uuid) {
        // we hold the lock
        progress?.finish(showTiming: true);
        break;
      }
      if (id == null) {
        // weird state, delete the lock and try again
        await _tryDeleteCacheFileLock(cacheFileLock);
        continue;
      }
      final DateTime lockAcquired = bytes.skip(1).dateTime;
      if (now.difference(lockAcquired) > const Duration(seconds: 30)) {
        // stale lock, delete it and try again
        await _tryDeleteCacheFileLock(cacheFileLock);
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
      ..writeAsBytesSync(<int>[uuid, ...DateTime.now().bytes]);
    Timer.periodic(
      const Duration(seconds: 10),
      (Timer timer) async {
        if (cacheFileLock.existsSync()) {
          final int? id = (await cacheFileLock.readAsBytes()).firstOrNull;
          if (id == uuid) {
            await cacheFileLock
                .writeAsBytes(<int>[uuid, ...DateTime.now().bytes]);
            return;
          }
        }
        timer.cancel();
      },
    );
    logger.trace("Acquired $_loggerFileIdentifier lock: $uuid");
    return true;
  }

  Future<void> _unlock(_DownloadEntry entry) async {
    final File cacheFileLock = _cacheFileLock(entry, cacheDir);
    if (cacheFileLock.existsSync()) {
      final int? id = (await cacheFileLock.readAsBytes()).firstOrNull;
      if (id == uuid) {
        await _tryDeleteCacheFileLock(cacheFileLock);
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
