import 'package:equatable/equatable.dart';

/// Generic offset/limit pagination request (matches PokeAPI's scheme but is
/// intentionally backend-agnostic).
class PageRequest extends Equatable {
  const PageRequest({this.offset = 0, this.limit = 20});

  final int offset;
  final int limit;

  PageRequest copyWith({int? offset, int? limit}) =>
      PageRequest(offset: offset ?? this.offset, limit: limit ?? this.limit);

  PageRequest next() => copyWith(offset: offset + limit);

  @override
  List<Object?> get props => [offset, limit];
}
