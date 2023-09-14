part of dartpip_solver;

/// A collection of functions for interacting with PyPI.
final class PyPIService {
  /// Call [PyPIService().someMethod()] to use this service.
  factory PyPIService() => _instance;

  PyPIService._();

  static final PyPIService _instance = PyPIService._();

  final LazyFuture<Directory> _cacheDir = LazyFuture<Directory>(
    () async {
      final Directory cacheDir = Directory(
        "${Platform.environment["HOME"]}/.dartpip/cache/pypi",
      );
      await cacheDir.create(recursive: true);
      PythonFfiDelegate.logger.trace("Cache directory: ${cacheDir.path}");
      return cacheDir;
    },
  );

  /// The directory where downloaded packages are stored.
  Future<Directory> get cacheDir => _cacheDir;

  final PyPIClient _client = PyPIClient();
  final http.Client _httpClient = http.Client();

  /// The [PyPIClient] used by this service.
  PyPIClient get client => _client;

  /// Downloads a project from PyPI if it is not already downloaded.
  /// Returns the version of the downloaded project.
  Future<String?> fetch({
    required String projectName,
    String version = "any",
  }) async {
    final Directory outputDir = await _cacheDir;
    final RegExp versionRegex = RegExp(r"^\^?(\d+\.\d+\.\d+)$");
    final Match? versionMatch = versionRegex.allMatches(version).singleOrNull;
    final String? effectiveVersion = switch (version) {
      "any" => await _client.latestVersion(projectName),
      String() when versionMatch != null => versionMatch.group(1)!,
      _ => await _client.latestVersion(projectName),
    };
    if (effectiveVersion == null) {
      return null;
    }
    final Directory projectDir =
        Directory("${outputDir.path}/$projectName-$effectiveVersion");
    if (projectDir.existsSync()) {
      PythonFfiDelegate.logger.trace(
        "Project '$projectName' is already downloaded.",
      );
      return effectiveVersion;
    }
    final Progress downloadProgress = PythonFfiDelegate.logger.progress(
      "Downloading Python module '$projectName'...",
    );
    final String? url = await _client.downloadUrl(
      projectName: projectName,
      version: effectiveVersion,
      packageType: PackageType.sdist,
    );
    if (url == null) {
      return null;
    }
    PythonFfiDelegate.logger.trace("Downloading $url...");
    final String filename = url.split("/").last;
    final http.Response response = await _httpClient.get(Uri.parse(url));
    final File outputFile = File("${outputDir.path}/$filename")
      ..createSync(recursive: true);
    await outputFile.writeAsBytes(response.bodyBytes);
    PythonFfiDelegate.logger.trace("Extracting ${outputFile.path}...");
    await extractFileToDisk(outputFile.path, outputDir.path);
    Directory? extractedDir;
    for (final FileSystemEntity entity in outputDir.listSync()) {
      if (entity is Directory && filename.startsWith(entity.name)) {
        extractedDir = entity;
        break;
      }
    }
    await outputFile.delete();
    if (extractedDir == null) {
      throw StateError("Could not find extracted directory.");
    }
    await extractedDir.rename(projectDir.path);
    downloadProgress.finish(showTiming: true);
    return effectiveVersion;
  }
}
