part of 'properties_bloc.dart';

abstract class PropertiesState extends Equatable {
  const PropertiesState();

  @override
  List<Object> get props => [];
}

class PropertiesInitial extends PropertiesState {}

class PropertiesLoading extends PropertiesState {}

class NoInternetSate extends PropertiesState {}

class PropertyLoaded extends PropertiesState {
  final List<PropertyEntity> properties;
  const PropertyLoaded({required this.properties});
  @override
  List<Object> get props => [properties];
}

class PropertiesError extends PropertiesState {
  final String message;
  const PropertiesError({required this.message});
  @override
  List<Object> get props => [message];
}
