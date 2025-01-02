import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String city;

  const CityEntity({required this.city});

  @override
  List<Object?> get props => [city];
}
