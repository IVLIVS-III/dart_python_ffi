part of dartpip;

final class PyPIService {
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

  final PyPIClient _client = PyPIClient();
  final http.Client _httpClient = http.Client();

  Future<void> fetch({required String projectName}) async {
    final Directory outputDir = await _cacheDir;
    final String version = await _client.latestVersion(projectName);
    final Directory projectDir =
        Directory("${outputDir.path}/$projectName-$version");
    if (projectDir.existsSync()) {
      print("Project '$projectName' is already downloaded.");
      return;
    }
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
    await outputFile.delete();
  }
}
