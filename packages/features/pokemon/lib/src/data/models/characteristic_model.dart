import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/characteristic.dart';
import 'package:json_annotation/json_annotation.dart';

part 'characteristic_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CharacteristicModel {
  const CharacteristicModel({
    required this.id,
    required this.geneModulo,
    required this.possibleValues,
    required this.highestStat,
    this.descriptions = const [],
  });

  factory CharacteristicModel.fromJson(DataMap json) =>
      _$CharacteristicModelFromJson(json);

  final int id;

  @JsonKey(name: 'gene_modulo')
  final int geneModulo;

  @JsonKey(name: 'possible_values')
  final List<int> possibleValues;

  @JsonKey(name: 'highest_stat')
  final NamedApiResourceModel highestStat;

  final List<LocalizedDescriptionModel> descriptions;

  DataMap toJson() => _$CharacteristicModelToJson(this);

  Characteristic toEntity() => Characteristic(
    id: id,
    geneModulo: geneModulo,
    possibleValues: possibleValues,
    highestStat: highestStat.toEntity(),
    description: _englishDescription(),
  );

  String? _englishDescription() {
    if (descriptions.isEmpty) {
      return null;
    }
    return descriptions
        .firstWhere(
          (d) => d.language.name == 'en',
          orElse: () => descriptions.first,
        )
        .description;
  }
}
