import 'package:minapp/features/host/features/properties/domain/entities/amenity_entity.dart';

class AmenityModel extends AmenityEntity {
  const AmenityModel({required String amenity}) : super(amenity: amenity);

  factory AmenityModel.fromJson(Map<String, dynamic> json) {
    return AmenityModel(
      amenity: json['amenity'],
    );
  }
}
