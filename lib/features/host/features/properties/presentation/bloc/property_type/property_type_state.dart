part of 'property_type_bloc.dart';

class PropertyTypeState extends Equatable {
  final List<PropertyTypeEntity> propertyTypes;
  final PropertyTypeEntity? selectedPropertyType;
  const PropertyTypeState(
      {this.propertyTypes = const [], this.selectedPropertyType});

  PropertyTypeState copyWith(
      {List<PropertyTypeEntity>? propertyTypes,
      PropertyTypeEntity? selectedPropertyType}) {
    return PropertyTypeState(
        propertyTypes: propertyTypes ?? this.propertyTypes,
        selectedPropertyType:
            selectedPropertyType ?? this.selectedPropertyType);
  }

  @override
  List<Object> get props => [propertyTypes, selectedPropertyType ?? ''];
}

class PropertyTypeLoadingState extends PropertyTypeState {}

class PropertyTypeError extends PropertyTypeState {
  final String message;
  const PropertyTypeError({required this.message});
}
