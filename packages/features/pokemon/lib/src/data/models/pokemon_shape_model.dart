import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_shape.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_shape_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonShapeModel {
  const PokemonShapeModel({
    required this.id,
    required this.name,
    this.names = const [],
    this.awesomeNames = const [],
    this.pokemonSpecies = const [],
  });

  factory PokemonShapeModel.fromJson(DataMap json) =>
      _$PokemonShapeModelFromJson(json);

  final int id;
  final String name;
  final List<LocalizedNameModel> names;

  @JsonKey(name: 'awesome_names')
  final List<ShapeAwesomeNameModel> awesomeNames;

  @JsonKey(name: 'pokemon_species')
  final List<NamedApiResourceModel> pokemonSpecies;

  DataMap toJson() => _$PokemonShapeModelToJson(this);

  PokemonShape toEntity() => PokemonShape(
    id: id,
    name: name,
    displayName: pickEnglishName(names),
    awesomeNames: awesomeNames.map((e) => e.toEntity()).toList(),
    pokemonSpecies: pokemonSpecies.map((e) => e.toEntity()).toList(),
  );
}

@JsonSerializable(explicitToJson: true)
class ShapeAwesomeNameModel {
  const ShapeAwesomeNameModel({
    required this.awesomeName,
    required this.language,
  });

  factory ShapeAwesomeNameModel.fromJson(DataMap json) =>
      _$ShapeAwesomeNameModelFromJson(json);

  @JsonKey(name: 'awesome_name')
  final String awesomeName;

  final NamedApiResourceModel language;

  DataMap toJson() => _$ShapeAwesomeNameModelToJson(this);

  ShapeAwesomeName toEntity() => ShapeAwesomeName(
    awesomeName: awesomeName,
    language: language.toEntity(),
  );
}
