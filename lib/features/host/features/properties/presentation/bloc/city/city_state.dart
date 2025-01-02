part of 'city_bloc.dart';

class CityState extends Equatable {
  const CityState({this.cities = const []});

  final List<CityEntity> cities;

  CityState copyWith({List<CityEntity>? cities}) {
    return CityState(cities: cities ?? this.cities);
  }

  @override
  List<Object> get props => [cities];
}

class CityLoading extends CityState {}

class CityErrorState extends CityState {
  final String message;
  const CityErrorState({required this.message});
}
