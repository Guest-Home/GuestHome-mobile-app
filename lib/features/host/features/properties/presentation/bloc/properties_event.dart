part of 'properties_bloc.dart';

abstract class PropertiesEvent extends Equatable {
  const PropertiesEvent();

  @override
  List<Object> get props => [];
}

class GetPropertiesEvent extends PropertiesEvent {}
