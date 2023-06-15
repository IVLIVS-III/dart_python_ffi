import "dart:convert";

import "package:dartpip/dartpip.dart";
import "package:http/http.dart" as http;
import "package:json_annotation/json_annotation.dart";

part "api.g.dart";

@JsonSerializable()
final class ProjectResponseInfo {
  ProjectResponseInfo({
    required this.version,
  });

  factory ProjectResponseInfo.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponseInfoFromJson(json);
  final String version;

  Map<String, dynamic> toJson() => _$ProjectResponseInfoToJson(this);
}

@JsonSerializable()
final class ProjectResponse {
  ProjectResponse({
    required this.info,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectResponseFromJson(json);
  final ProjectResponseInfo info;

  Map<String, dynamic> toJson() => _$ProjectResponseToJson(this);
}

@JsonSerializable()
final class ReleaseResponseUrl {
  ReleaseResponseUrl({
    required this.packageType,
    required this.url,
  });

  factory ReleaseResponseUrl.fromJson(Map<String, dynamic> json) =>
      _$ReleaseResponseUrlFromJson(json);

  @JsonKey(name: "packagetype")
  final String packageType;

  final String url;

  Map<String, dynamic> toJson() => _$ReleaseResponseUrlToJson(this);
}

final class ReleaseResponseUrlsConverter
    implements
        JsonConverter<List<ReleaseResponseUrl>, List<Map<String, dynamic>>> {
  const ReleaseResponseUrlsConverter();

  @override
  List<ReleaseResponseUrl> fromJson(List<Map<String, dynamic>> json) =>
      json.map(ReleaseResponseUrl.fromJson).toList();

  @override
  List<Map<String, dynamic>> toJson(List<ReleaseResponseUrl> object) =>
      object.map((ReleaseResponseUrl url) => url.toJson()).toList();
}

@JsonSerializable()
final class ReleaseResponse {
  ReleaseResponse({required this.urls});

  factory ReleaseResponse.fromJson(Map<String, dynamic> json) =>
      _$ReleaseResponseFromJson(json);

  @ReleaseResponseUrlsConverter()
  final List<ReleaseResponseUrl> urls;

  Map<String, dynamic> toJson() => _$ReleaseResponseToJson(this);
}

final class PyPIAPI {
  PyPIAPI(this._client);

  final PyPIClient _client;

  Future<Map<String, dynamic>> _get(Uri uri) async {
    final http.Response response = await _client.get(uri);
    final Map<String, dynamic> responseJson =
        (jsonDecode(response.body) as Map<dynamic, dynamic>)
            .cast<String, dynamic>();
    return responseJson;
  }

  Future<ProjectResponse> project(String projectName) async {
    final Uri uri = Uri.parse(
      "https://pypi.org/pypi/$projectName/json",
    );
    final Map<String, dynamic> responseJson = await _get(uri);
    return ProjectResponse.fromJson(responseJson);
  }

  Future<ReleaseResponse> release(String projectName, String version) async {
    final Uri uri = Uri.parse(
      "https://pypi.org/pypi/$projectName/$version/json",
    );
    final Map<String, dynamic> responseJson = await _get(uri);
    return ReleaseResponse.fromJson(responseJson);
  }
}
