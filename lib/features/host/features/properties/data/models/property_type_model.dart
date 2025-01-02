import '../../domain/entities/property_type_entity.dart';

class PropertyTypeModel extends PropertyTypeEntity {
  const PropertyTypeModel({required String propertyType})
      : super(propertyType: propertyType);

  factory PropertyTypeModel.fromJson(Map<String, dynamic> json) {
    return PropertyTypeModel(
      propertyType: json['property_type'],
    );
  }
}
