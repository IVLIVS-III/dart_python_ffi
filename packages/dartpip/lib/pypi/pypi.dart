part of dartpip;

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
      print("Cache directory: ${cacheDir.path}");
      return cacheDir;
    },
  );

  /// The directory where downloaded packages are stored.
  Future<Directory> get cacheDir => _cacheDir;

  final PyPIClient _client = PyPIClient();
  final http.Client _httpClient = http.Client();

  /// Downloads a project from PyPI if it is not already downloaded.
  /// Returns the version of the downloaded project.
  Future<String> fetch({required String projectName}) async {
    final Directory outputDir = await _cacheDir;
    final String version = await _client.latestVersion(projectName);
    final Directory projectDir =
        Directory("${outputDir.path}/$projectName-$version");
    if (projectDir.existsSync()) {
      print("Project '$projectName' is already downloaded.");
      return version;
    }
    print("Downloading Python module '$projectName'...");
    final String url = await _client.downloadUrl(
      projectName: projectName,
      version: version,
      packageType: PackageType.sdist,
    );
    print("Downloading $url...");
    final String filename = url.split("/").last;
    final http.Response response = await _httpClient.get(Uri.parse(url));
    final File outputFile = File("${outputDir.path}/$filename")
      ..createSync(recursive: true);
    await outputFile.writeAsBytes(response.bodyBytes);
    print("Extracting ${outputFile.path}...");
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
    return version;
  }
}
