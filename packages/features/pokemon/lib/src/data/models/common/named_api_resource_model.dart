import 'package:core/core.dart';
import 'package:feature_pokemon/src/domain/entities/common/named_api_resource.dart';
import 'package:json_annotation/json_annotation.dart';

part 'named_api_resource_model.g.dart';

/// JSON model for the ubiquitous `{ name, url }` PokéAPI reference object.
@JsonSerializable()
class NamedApiResourceModel {
  const NamedApiResourceModel({required this.name, required this.url});

  factory NamedApiResourceModel.fromJson(DataMap json) =>
      _$NamedApiResourceModelFromJson(json);

  final String name;
  final String url;

  DataMap toJson() => _$NamedApiResourceModelToJson(this);

  NamedApiResource toEntity() => NamedApiResource(name: name, url: url);
}

/// JSON model for a url-only `{ url }` PokéAPI reference object.
@JsonSerializable()
class ApiResourceModel {
  const ApiResourceModel({required this.url});

  factory ApiResourceModel.fromJson(DataMap json) =>
      _$ApiResourceModelFromJson(json);

  final String url;

  DataMap toJson() => _$ApiResourceModelToJson(this);

  ApiResource toEntity() => ApiResource(url: url);
}

/// JSON model for `{ name, language }`.
@JsonSerializable(explicitToJson: true)
class LocalizedNameModel {
  const LocalizedNameModel({required this.name, required this.language});

  factory LocalizedNameModel.fromJson(DataMap json) =>
      _$LocalizedNameModelFromJson(json);

  final String name;
  final NamedApiResourceModel language;

  DataMap toJson() => _$LocalizedNameModelToJson(this);

  LocalizedName toEntity() =>
      LocalizedName(name: name, language: language.toEntity());
}

/// JSON model for `{ description, language }`.
@JsonSerializable(explicitToJson: true)
class LocalizedDescriptionModel {
  const LocalizedDescriptionModel({
    required this.description,
    required this.language,
  });

  factory LocalizedDescriptionModel.fromJson(DataMap json) =>
      _$LocalizedDescriptionModelFromJson(json);

  final String description;
  final NamedApiResourceModel language;

  DataMap toJson() => _$LocalizedDescriptionModelToJson(this);

  LocalizedDescription toEntity() => LocalizedDescription(
    description: description,
    language: language.toEntity(),
  );
}

/// JSON model for a flavor-text entry.
@JsonSerializable(explicitToJson: true)
class FlavorTextModel {
  const FlavorTextModel({
    required this.text,
    required this.language,
    this.version,
    this.versionGroup,
  });

  factory FlavorTextModel.fromJson(DataMap json) =>
      _$FlavorTextModelFromJson(json);

  @JsonKey(name: 'flavor_text')
  final String text;

  final NamedApiResourceModel language;
  final NamedApiResourceModel? version;

  @JsonKey(name: 'version_group')
  final NamedApiResourceModel? versionGroup;

  DataMap toJson() => _$FlavorTextModelToJson(this);

  FlavorText toEntity() => FlavorText(
    text: text,
    language: language.toEntity(),
    version: version?.toEntity(),
    versionGroup: versionGroup?.toEntity(),
  );
}

/// JSON model for a genus entry `{ genus, language }`.
@JsonSerializable(explicitToJson: true)
class GenusModel {
  const GenusModel({required this.genus, required this.language});

  factory GenusModel.fromJson(DataMap json) => _$GenusModelFromJson(json);

  final String genus;
  final NamedApiResourceModel language;

  DataMap toJson() => _$GenusModelToJson(this);

  Genus toEntity() => Genus(genus: genus, language: language.toEntity());
}

/// Shared helpers for parsing lists of reference objects.
extension NamedApiResourceListJson on List<dynamic>? {
  List<NamedApiResourceModel> toNamedApiResourceModels() => (this ?? [])
      .map((dynamic e) => NamedApiResourceModel.fromJson(e as DataMap))
      .toList();
}

/// Picks the English entry from a list of localized names, falling back to the
/// first available entry, or null when the list is empty.
String? pickEnglishName(List<LocalizedNameModel> names) {
  if (names.isEmpty) {
    return null;
  }
  return names
      .firstWhere(
        (n) => n.language.name == 'en',
        orElse: () => names.first,
      )
      .name;
}
