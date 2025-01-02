import 'package:equatable/equatable.dart';

class AmenityEntity extends Equatable {
  final String amenity;

  const AmenityEntity({required this.amenity});

  @override
  List<Object?> get props => [amenity];
}
