part of python_ffi_cpython_dart;

abstract base class _Cache {
  _Cache({required this.version, required this.cacheDir}) {
    if (!cacheDir.existsSync()) {
      cacheDir.createSync(recursive: true);
    }
  }

  final String version;
  final Directory cacheDir;

  Logger get logger => PythonFfiDelegate.logger;
  final int uuid = Random().nextDouble().hashCode % 256;

  _DownloadEntry? get _entry;

  String get _loggerFileIdentifier;

  File _cacheFile(_DownloadEntry entry, Directory cacheDir) =>
      File(p.join(cacheDir.path, entry.filename));

  File _cacheFileLock(_DownloadEntry entry, Directory cacheDir) =>
      File(p.join(cacheDir.path, "${entry.filename}.lock"));

  Future<T> _withLock<T>(
    File file,
    FutureOr<T> Function(RandomAccessFile lockedFile) callback,
  ) async {
    final RandomAccessFile lockedFile = await _lockThreadSafe(file);
    final T result = await callback(lockedFile);
    await _unlockThreadSafe(lockedFile);
    return result;
  }

  Future<RandomAccessFile> _lockThreadSafe(File file) async {
    late final Progress progress;
    // Try to get the lock synchronously. This is a non-blocking operation.
    // If it fails, someone else has the lock and we need to wait for them to
    // release it.
    try {
      final RandomAccessFile fileHandle = file.openSync(mode: FileMode.write)
        ..lockSync(FileLock.exclusive);
      logger.trace(
        "[$uuid] Acquired $_loggerFileIdentifier lock: '${file.path}'",
      );
      return fileHandle;
    } on Exception catch (e) {
      if (e is! OSError && e is! FileSystemException) {
        rethrow;
      }
      logger.trace(
        "[$uuid] Failed to acquire $_loggerFileIdentifier lock: '${file.path}'\n$e",
      );
      progress = logger.progress(
        "Waiting for another command to release the $_loggerFileIdentifier lock",
      );
    }

    // Try to get the lock asynchronously, since someone else holds the lock.
    const Duration sleep = Duration(milliseconds: 100);
    while (true) {
      try {
        final RandomAccessFile fileHandle = file.openSync(mode: FileMode.write);
        await fileHandle.lock(FileLock.blockingExclusive);
        progress.finish(showTiming: true);
        logger.trace(
          "[$uuid] Acquired $_loggerFileIdentifier lock: '${file.path}'",
        );
        return fileHandle;
      } on Exception catch (e) {
        if (e is! OSError && e is! FileSystemException) {
          rethrow;
        }
        logger.trace(
          "[$uuid] Failed to acquire $_loggerFileIdentifier lock: '${file.path}'\n$e",
        );
        await Future<void>.delayed(sleep);
      }
    }
  }

  Future<bool> _unlockThreadSafe(RandomAccessFile lockedFile) async {
    try {
      await lockedFile.unlock();
      await lockedFile.close();
      logger.trace(
        "[$uuid] Released $_loggerFileIdentifier lock: '${lockedFile.path}'",
      );
      return true;
    } on Exception catch (e) {
      if (e is! OSError && e is! FileSystemException) {
        rethrow;
      }
      logger.trace(
        "[$uuid] Failed to release $_loggerFileIdentifier lock: '${lockedFile.path}'\n$e",
      );
      return false;
    }
  }

  Future<bool> _tryDeleteCacheFile(File cacheFile) async {
    try {
      await cacheFile.delete(recursive: true);
      return true;
    } on Exception catch (e) {
      if (e is! OSError && e is! FileSystemException) {
        rethrow;
      }
      logger.stderr("Failed to delete $_loggerFileIdentifier: $e");
    }
    return false;
  }

  /// Must be called while holding the lockFile lock.
  Future<bool> _exists(_DownloadEntry entry) async {
    final File cacheFile = _cacheFile(entry, cacheDir);
    try {
      if (!cacheFile.existsSync()) {
        logger.trace("$_loggerFileIdentifier does not exist");
        return false;
      }
      final Uint8List bytes = await cacheFile.readAsBytes();
      final crypto.Digest digest = crypto.sha256.convert(bytes);
      final String sha256 = digest.toString().toLowerCase();
      final bool result = sha256 == entry.sha256.toLowerCase();
      if (!result) {
        logger.trace(
          "$_loggerFileIdentifier does not match sha256: expected '${entry.sha256.toLowerCase()}', got '$sha256'",
        );
        await _tryDeleteCacheFile(cacheFile);
      }
      return result;
    } on Exception catch (e) {
      if (e is! OSError && e is! FileSystemException) {
        rethrow;
      }
      logger.stderr(
        "Failed to read $_loggerFileIdentifier: $e",
      );
      return false;
    }
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
  static Future<(T, Iterable<E1>, Iterable<E2>)>
      exceptionalRetry<T, E1 extends Exception, E2 extends Exception>(
    FutureOr<T> Function() callback, {
    int maxRetries = 7,
    Duration backoff = const Duration(milliseconds: 100),
    T? exceptionalReturn,
  }) async {
    try {
      final T result = await callback();
      return (result, <E1>[], <E2>[]);
    } on Exception catch (e) {
      final List<E1> e1 = <E1>[];
      final List<E2> e2 = <E2>[];

      if (e is E1) {
        e1.add(e);
      } else if (e is E2) {
        e2.add(e);
      } else {
        rethrow;
      }

      if (maxRetries == 0) {
        if (exceptionalReturn != null) {
          return (exceptionalReturn, e1, e2);
        }
        rethrow;
      }
      await Future<void>.delayed(backoff);
      final (T result, Iterable<E1> prevE1, Iterable<E2> prevE2) =
          await exceptionalRetry(
        callback,
        maxRetries: maxRetries - 1,
        backoff: backoff * 2,
      );
      return (result, prevE1.followedBy(e1), prevE2.followedBy(e2));
    }
  }

  /// Must be called while holding the lock.
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
    logger.trace("Downloaded $offset / ${response.contentLength} bytes");

    final (
      bool result,
      Iterable<OSError> e1,
      Iterable<FileSystemException> e2
    ) = await exceptionalRetry<bool, OSError, FileSystemException>(
      () async {
        await _withLock(
          cacheFile,
          (RandomAccessFile lockedFile) async {
            await lockedFile.writeFrom(bytes);
            await lockedFile.flush();
          },
        );
        return true;
      },
      backoff: const Duration(seconds: 1),
      exceptionalReturn: false,
    );
    downloadProgress.finish(showTiming: true);
    if (!result) {
      logger.stderr(
        "$_loggerFileIdentifier download failed:\n${e1.join('\n')}\n${e2.join('\n')}",
      );
      return false;
    }
    logger.trace("$_loggerFileIdentifier written to '${cacheFile.path}'");
    final bool success = await _exists(entry);
    if (!success) {
      logger.stderr("$_loggerFileIdentifier download failed, doesn't exist");
      await _tryDeleteCacheFile(cacheFile);
    }
    return success;
  }

  Future<bool> ensure() async {
    final _DownloadEntry? entry = _entry;
    if (entry == null) {
      return false;
    }
    final File file = _cacheFileLock(entry, cacheDir);
    return _withLock(
      file,
      (RandomAccessFile lockFile) async {
        if (await _exists(entry)) {
          return true;
        }
        return _get(entry);
      },
    );
  }
}
