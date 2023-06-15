// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectResponseInfo _$ProjectResponseInfoFromJson(Map<String, dynamic> json) =>
    ProjectResponseInfo(
      version: json['version'] as String,
    );

Map<String, dynamic> _$ProjectResponseInfoToJson(
        ProjectResponseInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
    };

ProjectResponse _$ProjectResponseFromJson(Map<String, dynamic> json) =>
    ProjectResponse(
      info: ProjectResponseInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProjectResponseToJson(ProjectResponse instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

ReleaseResponseUrl _$ReleaseResponseUrlFromJson(Map<String, dynamic> json) =>
    ReleaseResponseUrl(
      packageType: json['packagetype'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$ReleaseResponseUrlToJson(ReleaseResponseUrl instance) =>
    <String, dynamic>{
      'packagetype': instance.packageType,
      'url': instance.url,
    };

ReleaseResponse _$ReleaseResponseFromJson(Map<String, dynamic> json) =>
    ReleaseResponse(
      urls: const ReleaseResponseUrlsConverter()
          .fromJson(json['urls'] as List<Map<String, dynamic>>),
    );

Map<String, dynamic> _$ReleaseResponseToJson(ReleaseResponse instance) =>
    <String, dynamic>{
      'urls': const ReleaseResponseUrlsConverter().toJson(instance.urls),
    };
