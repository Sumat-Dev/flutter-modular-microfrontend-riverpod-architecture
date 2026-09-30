import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/egg_group.dart';
import 'package:json_annotation/json_annotation.dart';

part 'egg_group_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EggGroupModel {
  const EggGroupModel({
    required this.id,
    required this.name,
    this.names = const [],
    this.pokemonSpecies = const [],
  });

  factory EggGroupModel.fromJson(DataMap json) => _$EggGroupModelFromJson(json);

  final int id;
  final String name;
  final List<LocalizedNameModel> names;

  @JsonKey(name: 'pokemon_species')
  final List<NamedApiResourceModel> pokemonSpecies;

  DataMap toJson() => _$EggGroupModelToJson(this);

  EggGroup toEntity() => EggGroup(
    id: id,
    name: name,
    displayName: pickEnglishName(names),
    pokemonSpecies: pokemonSpecies.map((e) => e.toEntity()).toList(),
  );
}
