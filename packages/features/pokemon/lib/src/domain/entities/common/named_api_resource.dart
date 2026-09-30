import 'package:equatable/equatable.dart';

/// A reference to another PokéAPI resource that has a `name` and a `url`.
///
/// This is the ubiquitous `{ "name": ..., "url": ... }` object returned all
/// over the PokéAPI (types, abilities, species, generations, languages, ...).
class NamedApiResource extends Equatable {
  const NamedApiResource({required this.name, required this.url});

  final String name;
  final String url;

  /// The trailing numeric id embedded in [url], or 0 when absent.
  int get id {
    final segments = url.split('/').where((s) => s.isNotEmpty).toList();
    final last = segments.isNotEmpty ? segments.last : '';
    return int.tryParse(last) ?? 0;
  }

  @override
  List<Object?> get props => [name, url];
}

/// A reference to another PokéAPI resource that only carries a `url`
/// (e.g. `evolution_chain`, `characteristic` list entries).
class ApiResource extends Equatable {
  const ApiResource({required this.url});

  final String url;

  /// The trailing numeric id embedded in [url], or 0 when absent.
  int get id {
    final segments = url.split('/').where((s) => s.isNotEmpty).toList();
    final last = segments.isNotEmpty ? segments.last : '';
    return int.tryParse(last) ?? 0;
  }

  @override
  List<Object?> get props => [url];
}

/// A localized display name: `{ "name": ..., "language": {...} }`.
class LocalizedName extends Equatable {
  const LocalizedName({required this.name, required this.language});

  final String name;
  final NamedApiResource language;

  @override
  List<Object?> get props => [name, language];
}

/// A localized description: `{ "description": ..., "language": {...} }`.
class LocalizedDescription extends Equatable {
  const LocalizedDescription({
    required this.description,
    required this.language,
  });

  final String description;
  final NamedApiResource language;

  @override
  List<Object?> get props => [description, language];
}

/// A localized flavor-text entry with an optional version(-group) reference.
class FlavorText extends Equatable {
  const FlavorText({
    required this.text,
    required this.language,
    this.version,
    this.versionGroup,
  });

  final String text;
  final NamedApiResource language;
  final NamedApiResource? version;
  final NamedApiResource? versionGroup;

  @override
  List<Object?> get props => [text, language, version, versionGroup];
}

/// A localized genus (used by Pokémon species, e.g. "Seed Pokémon").
class Genus extends Equatable {
  const Genus({required this.genus, required this.language});

  final String genus;
  final NamedApiResource language;

  @override
  List<Object?> get props => [genus, language];
}
