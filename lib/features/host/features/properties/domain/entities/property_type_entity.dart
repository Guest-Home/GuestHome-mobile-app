import 'package:equatable/equatable.dart';

class PropertyTypeEntity extends Equatable {
  final String propertyType;

  const PropertyTypeEntity({required this.propertyType});

  @override
  List<Object?> get props => [propertyType];
}
