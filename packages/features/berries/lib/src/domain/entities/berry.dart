import 'package:equatable/equatable.dart';

/// Lightweight berry summary used in list views.
class Berry extends Equatable {
  const Berry({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
