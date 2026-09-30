import 'package:core/core.dart';
import 'package:feature_pokemon/src/data/models/common/named_api_resource_model.dart';
import 'package:feature_pokemon/src/domain/entities/pokemon_form.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_form_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PokemonFormModel {
  const PokemonFormModel({
    required this.id,
    required this.name,
    required this.order,
    required this.formOrder,
    required this.isDefault,
    required this.isBattleOnly,
    required this.isMega,
    required this.formName,
    this.pokemon,
    this.types = const [],
    this.spriteUrl,
  });

  factory PokemonFormModel.fromJson(DataMap json) =>
      _$PokemonFormModelFromJson(json);

  final int id;
  final String name;
  final int order;

  @JsonKey(name: 'form_order')
  final int formOrder;

  @JsonKey(name: 'is_default')
  final bool isDefault;

  @JsonKey(name: 'is_battle_only')
  final bool isBattleOnly;

  @JsonKey(name: 'is_mega')
  final bool isMega;

  @JsonKey(name: 'form_name')
  final String formName;

  final NamedApiResourceModel? pokemon;

  @JsonKey(fromJson: _typesFromJson, toJson: _typesToJson)
  final List<String> types;

  @JsonKey(name: 'sprites', fromJson: _spriteFromJson, toJson: _spriteToJson)
  final String? spriteUrl;

  DataMap toJson() => _$PokemonFormModelToJson(this);

  PokemonForm toEntity() => PokemonForm(
    id: id,
    name: name,
    order: order,
    formOrder: formOrder,
    isDefault: isDefault,
    isBattleOnly: isBattleOnly,
    isMega: isMega,
    formName: formName,
    pokemon: pokemon?.toEntity(),
    types: types,
    spriteUrl: spriteUrl,
  );

  static List<String> _typesFromJson(List<dynamic>? raw) => (raw ?? [])
      .map((dynamic t) => (t as DataMap)['type'] as DataMap)
      .map((DataMap t) => t['name'] as String)
      .toList();

  static List<Map<String, dynamic>> _typesToJson(List<String> types) => types
      .map(
        (t) => {
          'type': {'name': t},
        },
      )
      .toList();

  static String? _spriteFromJson(DataMap? sprites) =>
      sprites?['front_default'] as String?;

  static Map<String, dynamic> _spriteToJson(String? url) => {
    'front_default': url,
  };
}
