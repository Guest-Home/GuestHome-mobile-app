part of 'properties_bloc.dart';

abstract class PropertiesState extends Equatable {
  const PropertiesState();  

  @override
  List<Object> get props => [];
}
class PropertiesInitial extends PropertiesState {}
