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
      return cacheDir;
    },
  );

  final PyPIClient _client = PyPIClient();

  Future<void> fetch({
    required String packageName,
    required Directory outputDir,
  }) async {
    final String version = await _client.latestVersion(packageName);
    final String url = await _client.downloadUrl(
      projectName: packageName,
      version: version,
      packageType: "sdist",
    );
  }
}
