// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'named_api_resource_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NamedApiResourceModel _$NamedApiResourceModelFromJson(
  Map<String, dynamic> json,
) => NamedApiResourceModel(
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$NamedApiResourceModelToJson(
  NamedApiResourceModel instance,
) => <String, dynamic>{'name': instance.name, 'url': instance.url};

ApiResourceModel _$ApiResourceModelFromJson(Map<String, dynamic> json) =>
    ApiResourceModel(url: json['url'] as String);

Map<String, dynamic> _$ApiResourceModelToJson(ApiResourceModel instance) =>
    <String, dynamic>{'url': instance.url};

LocalizedNameModel _$LocalizedNameModelFromJson(Map<String, dynamic> json) =>
    LocalizedNameModel(
      name: json['name'] as String,
      language: NamedApiResourceModel.fromJson(
        json['language'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$LocalizedNameModelToJson(LocalizedNameModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'language': instance.language.toJson(),
    };

LocalizedDescriptionModel _$LocalizedDescriptionModelFromJson(
  Map<String, dynamic> json,
) => LocalizedDescriptionModel(
  description: json['description'] as String,
  language: NamedApiResourceModel.fromJson(
    json['language'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$LocalizedDescriptionModelToJson(
  LocalizedDescriptionModel instance,
) => <String, dynamic>{
  'description': instance.description,
  'language': instance.language.toJson(),
};

FlavorTextModel _$FlavorTextModelFromJson(Map<String, dynamic> json) =>
    FlavorTextModel(
      text: json['flavor_text'] as String,
      language: NamedApiResourceModel.fromJson(
        json['language'] as Map<String, dynamic>,
      ),
      version: json['version'] == null
          ? null
          : NamedApiResourceModel.fromJson(
              json['version'] as Map<String, dynamic>,
            ),
      versionGroup: json['version_group'] == null
          ? null
          : NamedApiResourceModel.fromJson(
              json['version_group'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$FlavorTextModelToJson(FlavorTextModel instance) =>
    <String, dynamic>{
      'flavor_text': instance.text,
      'language': instance.language.toJson(),
      'version': instance.version?.toJson(),
      'version_group': instance.versionGroup?.toJson(),
    };

GenusModel _$GenusModelFromJson(Map<String, dynamic> json) => GenusModel(
  genus: json['genus'] as String,
  language: NamedApiResourceModel.fromJson(
    json['language'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$GenusModelToJson(GenusModel instance) =>
    <String, dynamic>{
      'genus': instance.genus,
      'language': instance.language.toJson(),
    };
