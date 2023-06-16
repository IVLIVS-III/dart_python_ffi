part of dartpip;

final class PyPIClient with http.BaseClient implements http.Client {
  final http.Client _client = http.Client();

  late final PyPIAPI _api = PyPIAPI(this);

  // HttpHeaders are all lowercase
  static const Map<String, String> _overwrittenHeaders = <String, String>{
    HttpHeaders.userAgentHeader: "dartpip/$kDartpipVersion",
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

  Future<String> latestVersion(String projectName) async {
    final ProjectResponse projectResponse = await _api.project(projectName);
    return projectResponse.info.version;
  }

  Future<String> downloadUrl({
    required String projectName,
    required String version,
    required PackageType packageType,
  }) async {
    final ReleaseResponse releaseResponse =
        await _api.release(projectName, version);
    return releaseResponse.urls
        .firstWhere(
          (ReleaseResponseUrl url) => url.packageType == packageType,
        )
        .url;
  }
}
