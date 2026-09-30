import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/gender.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gender_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GenderModel {
  const GenderModel({
    required this.id,
    required this.name,
    this.pokemonSpeciesDetails = const [],
    this.requiredForEvolution = const [],
  });

  factory GenderModel.fromJson(DataMap json) => _$GenderModelFromJson(json);

  final int id;
  final String name;

  @JsonKey(name: 'pokemon_species_details')
  final List<GenderSpeciesDetailModel> pokemonSpeciesDetails;

  @JsonKey(name: 'required_for_evolution')
  final List<NamedApiResourceModel> requiredForEvolution;

  DataMap toJson() => _$GenderModelToJson(this);

  Gender toEntity() => Gender(
    id: id,
    name: name,
    pokemonSpeciesDetails: pokemonSpeciesDetails
        .map((e) => e.toEntity())
        .toList(),
    requiredForEvolution: requiredForEvolution
        .map((e) => e.toEntity())
        .toList(),
  );
}

@JsonSerializable(explicitToJson: true)
class GenderSpeciesDetailModel {
  const GenderSpeciesDetailModel({
    required this.rate,
    required this.pokemonSpecies,
  });

  factory GenderSpeciesDetailModel.fromJson(DataMap json) =>
      _$GenderSpeciesDetailModelFromJson(json);

  final int rate;

  @JsonKey(name: 'pokemon_species')
  final NamedApiResourceModel pokemonSpecies;

  DataMap toJson() => _$GenderSpeciesDetailModelToJson(this);

  GenderSpeciesDetail toEntity() => GenderSpeciesDetail(
    rate: rate,
    pokemonSpecies: pokemonSpecies.toEntity(),
  );
}
