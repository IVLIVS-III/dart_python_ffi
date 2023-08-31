import "dart:convert";

import "package:dartpip_solver/dartpip_solver.dart";
import "package:http/http.dart" as http;
import "package:json_annotation/json_annotation.dart";

part "api.g.dart";

/// Models the response object returned from the PyPI-API 'project' endpoint.
///
/// Reference: https://warehouse.pypa.io/api-reference/json.html#project
@JsonSerializable()
final class ProjectResponse {
  /// Default constructor for [ProjectResponse], required by build_runner.
  ProjectResponse({
    required this.info,
  });

  /// Factory constructor for [ProjectResponse], required by json_serializable.
  factory ProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponseFromJson(json);

  /// Field path: {project}.info
  ///
  /// See also: [ProjectResponseInfo]
  final ProjectResponseInfo info;

  /// Required by json_serializable.
  Map<String, dynamic> toJson() => _$ProjectResponseToJson(this);
}

/// Models part of the response object returned from the PyPI-API 'project'
/// endpoint.
/// Field path: {project}.info
///
/// Reference: https://warehouse.pypa.io/api-reference/json.html#project
@JsonSerializable()
final class ProjectResponseInfo {
  /// Default constructor for [ProjectResponseInfo], required by build_runner.
  ProjectResponseInfo({
    required this.version,
  });

  /// Factory constructor for [ProjectResponseInfo], required by
  /// json_serializable.
  factory ProjectResponseInfo.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponseInfoFromJson(json);

  /// Field path: {project}.info.version
  final String version;

  /// Required by json_serializable.
  Map<String, dynamic> toJson() => _$ProjectResponseInfoToJson(this);
}

/// Models the response object returned from the PyPI-API 'release' endpoint.
///
/// Reference: https://warehouse.pypa.io/api-reference/json.html#release
@JsonSerializable()
final class ReleaseResponse {
  /// Default constructor for [ReleaseResponse], required by build_runner.
  ReleaseResponse({
    required this.info,
    required this.urls,
  });

  /// Factory constructor for [ReleaseResponse], required by json_serializable.
  factory ReleaseResponse.fromJson(Map<String, dynamic> json) =>
      _$ReleaseResponseFromJson(json);

  /// Field path: {release}.info
  final ReleaseResponseInfo info;

  /// Field path: {release}.urls
  @_ReleaseResponseUrlsConverter()
  final List<ReleaseResponseUrl> urls;

  /// Required by json_serializable.
  Map<String, dynamic> toJson() => _$ReleaseResponseToJson(this);
}

/// Models part of the response object returned from the PyPI-API 'release'
/// endpoint.
/// Field path: {release}.info
///
/// Reference: https://warehouse.pypa.io/api-reference/json.html#release
@JsonSerializable()
final class ReleaseResponseInfo {
  /// Default constructor for [ReleaseResponseInfo], required by build_runner.
  ReleaseResponseInfo({
    required this.requiresDist,
  });

  /// Factory constructor for [ReleaseResponseInfo], required by
  /// json_serializable.
  factory ReleaseResponseInfo.fromJson(Map<String, dynamic> json) =>
      _$ReleaseResponseInfoFromJson(json);

  /// Field path: {release}.info.requires_dist
  @JsonKey(name: "requires_dist")
  final List<String>? requiresDist;

  /// Required by json_serializable.
  Map<String, dynamic> toJson() => _$ReleaseResponseInfoToJson(this);
}

/// Models part of the response object returned from the PyPI-API 'release'
/// endpoint.
/// Field path: {release}.urls
///
/// Reference: https://warehouse.pypa.io/api-reference/json.html#release
@JsonSerializable()
final class ReleaseResponseUrl {
  /// Default constructor for [ReleaseResponseUrl], required by build_runner.
  ReleaseResponseUrl({
    required this.packageType,
    required this.url,
  });

  /// Factory constructor for [ReleaseResponseUrl], required by
  /// json_serializable.
  factory ReleaseResponseUrl.fromJson(Map<String, dynamic> json) =>
      _$ReleaseResponseUrlFromJson(json);

  /// Field path: {release}.urls[].packagetype
  @JsonKey(name: "packagetype")
  final PackageType packageType;

  /// Field path: {release}.urls[].url
  final String url;

  /// Required by json_serializable.
  Map<String, dynamic> toJson() => _$ReleaseResponseUrlToJson(this);
}

final class _ReleaseResponseUrlsConverter
    implements JsonConverter<ReleaseResponseUrl, Map<String, dynamic>> {
  const _ReleaseResponseUrlsConverter();

  @override
  ReleaseResponseUrl fromJson(Map<String, dynamic> json) =>
      ReleaseResponseUrl.fromJson(json);

  @override
  Map<String, dynamic> toJson(ReleaseResponseUrl object) => object.toJson();
}

/// Models part of the response object returned from the PyPI-API 'release'
/// endpoint.
/// Field path: {release}.urls[].packagetype
///
/// Reference: https://github.com/pypi/warehouse/blob/main/warehouse/filters.py#L37
enum PackageType {
  /// Value for 'OSX Disk Image'.
  @JsonValue("bdist_dmg")
  bdistDmg("OSX Disk Image"),

  /// Value for 'Dumb Binary'.
  @JsonValue("bdist_dumb")
  bdistDumb("Dumb Binary"),

  /// Value for 'Egg'.
  @JsonValue("bdist_egg")
  bdistEgg("Egg"),

  /// Value for 'Windows Installer'.
  @JsonValue("bdist_msi")
  bdistMsi("Windows MSI Installer"),

  /// Value for 'RPM'.
  @JsonValue("bdist_rpm")
  bdistRpm("RPM"),

  /// Value for 'Wheel'.
  @JsonValue("bdist_wheel")
  bdistWheel("Wheel"),

  /// Value for 'Windows Installer'.
  @JsonValue("bdist_wininst")
  bdistWininst("Windows Installer"),

  /// Value for 'Source'.
  @JsonValue("sdist")
  sdist("Source");

  const PackageType(this.value);

  /// Human readable value for the package type as defined in
  /// https://github.com/pypi/warehouse/blob/main/warehouse/filters.py#L37.
  final String value;
}

/// Models the PyPI-API.
final class PyPIAPI {
  /// Pass a [PyPIClient] to the constructor which will be used to make HTTP
  /// requests to the PyPI-API.
  PyPIAPI(this._client);

  final PyPIClient _client;

  Future<Map<String, dynamic>> _get(Uri uri) async {
    final http.Response response = await _client.get(uri);
    final Map<String, dynamic> responseJson =
        (jsonDecode(response.body) as Map<dynamic, dynamic>)
            .cast<String, dynamic>();
    return responseJson;
  }

  /// Calls the PyPI-API 'project' endpoint.
  ///
  /// Reference: https://warehouse.pypa.io/api-reference/json.html#project
  Future<ProjectResponse> project(String projectName) async {
    final Uri uri = Uri.parse(
      "https://pypi.org/pypi/$projectName/json",
    );
    final Map<String, dynamic> responseJson = await _get(uri);
    return ProjectResponse.fromJson(responseJson);
  }

  /// Calls the PyPI-API 'release' endpoint.
  ///
  /// Reference: https://warehouse.pypa.io/api-reference/json.html#release
  Future<ReleaseResponse> release(String projectName, String version) async {
    final Uri uri = Uri.parse(
      "https://pypi.org/pypi/$projectName/$version/json",
    );
    final Map<String, dynamic> responseJson = await _get(uri);
    return ReleaseResponse.fromJson(responseJson);
  }
}
