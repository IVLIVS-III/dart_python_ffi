part of dartpip_solver;

/// A client for interacting with the the PyPI-API.
final class PyPIClient with http.BaseClient implements http.Client {
  final http.Client _client = http.Client();

  late final PyPIAPI _api = PyPIAPI(this);

  // HttpHeaders are all lowercase
  static const Map<String, String> _overwrittenHeaders = <String, String>{
    HttpHeaders.userAgentHeader: "dartpip/$kDartpipSolverVersion",
  };

  void _sanitizeHeaders(http.BaseRequest request) => request.headers
    ..removeWhere(
      (String key, String value) =>
          _overwrittenHeaders.containsKey(key.toLowerCase()),
    )
    ..addAll(_overwrittenHeaders);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    _sanitizeHeaders(request);
    return _client.send(request);
  }

  /// Returns the latest version of a project.
  Future<String> latestVersion(String projectName) async {
    final ProjectResponse projectResponse = await _api.project(projectName);
    return projectResponse.info.version;
  }

  /// Returns the requirements of a project.
  Future<List<String>> requirements(String projectName, String version) async {
    final ReleaseResponse releaseResponse = await _api.release(
      projectName,
      version,
    );
    return releaseResponse.info.requiresDist ?? <String>[];
  }

  /// Returns the download URL for a project.
  Future<String?> downloadUrl({
    required String projectName,
    required String version,
    required PackageType packageType,
  }) async {
    final ReleaseResponse releaseResponse =
        await _api.release(projectName, version);
    return releaseResponse.urls
        .firstWhereOrNull(
          (ReleaseResponseUrl url) => url.packageType == packageType,
        )
        ?.url;
  }
}
