import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_habitat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_habitat_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonHabitatModel {
  const PokemonHabitatModel({
    required this.id,
    required this.name,
    this.names = const [],
    this.pokemonSpecies = const [],
  });

  factory PokemonHabitatModel.fromJson(DataMap json) =>
      _$PokemonHabitatModelFromJson(json);

  final int id;
  final String name;
  final List<LocalizedNameModel> names;

  @JsonKey(name: 'pokemon_species')
  final List<NamedApiResourceModel> pokemonSpecies;

  DataMap toJson() => _$PokemonHabitatModelToJson(this);

  PokemonHabitat toEntity() => PokemonHabitat(
    id: id,
    name: name,
    displayName: pickEnglishName(names),
    pokemonSpecies: pokemonSpecies.map((e) => e.toEntity()).toList(),
  );
}
