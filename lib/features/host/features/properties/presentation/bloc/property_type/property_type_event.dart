part of 'property_type_bloc.dart';

sealed class PropertyTypeEvent extends Equatable {
  const PropertyTypeEvent();

  @override
  List<Object> get props => [];
}

class GetPropertyTypesEvent extends PropertyTypeEvent {}

class SelectPropertyType extends PropertyTypeEvent {
  final PropertyTypeEntity propertyType;
  const SelectPropertyType({required this.propertyType});
}
