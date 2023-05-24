part of python_ffi_cpython_dart;

abstract base class _Cache {
  _Cache({required this.version, required this.cacheDir});

  final String version;
  final Directory cacheDir;
  final Logger logger = Logger.standard();

  _DownloadEntry? get _entry;

  File _cacheFile(_DownloadEntry entry, Directory cacheDir) =>
      File("${cacheDir.path}/${entry.filename}");

  Future<bool> _exists(_DownloadEntry entry) async {
    final File cacheFile = _cacheFile(entry, cacheDir);
    if (!cacheFile.existsSync()) {
      return false;
    }
    final Uint8List bytes = await cacheFile.readAsBytes();
    final crypto.Digest digest = crypto.sha256.convert(bytes);
    return digest.toString() == entry.sha256;
  }

  String get _loggerFileIdentifier;

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
    await for (final List<int> chunk in response) {
      await cacheFile.writeAsBytes(chunk, mode: FileMode.append);
    }
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
    if (await _exists(entry)) {
      return true;
    }
    return _get(entry);
  }
}
