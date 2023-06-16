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
      packageType: $enumDecode(_$PackageTypeEnumMap, json['packagetype']),
      url: json['url'] as String,
    );

Map<String, dynamic> _$ReleaseResponseUrlToJson(ReleaseResponseUrl instance) =>
    <String, dynamic>{
      'packagetype': _$PackageTypeEnumMap[instance.packageType]!,
      'url': instance.url,
    };

const _$PackageTypeEnumMap = {
  PackageType.bdistDmg: 'bdist_dmg',
  PackageType.bdistDumb: 'bdist_dumb',
  PackageType.bdistEgg: 'bdist_egg',
  PackageType.bdistMsi: 'bdist_msi',
  PackageType.bdistRpm: 'bdist_rpm',
  PackageType.bdistWheel: 'bdist_wheel',
  PackageType.bdistWininst: 'bdist_wininst',
  PackageType.sdist: 'sdist',
};

ReleaseResponse _$ReleaseResponseFromJson(Map<String, dynamic> json) =>
    ReleaseResponse(
      urls: (json['urls'] as List<dynamic>)
          .map((e) => const ReleaseResponseUrlsConverter()
              .fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReleaseResponseToJson(ReleaseResponse instance) =>
    <String, dynamic>{
      'urls': instance.urls
          .map(const ReleaseResponseUrlsConverter().toJson)
          .toList(),
    };
