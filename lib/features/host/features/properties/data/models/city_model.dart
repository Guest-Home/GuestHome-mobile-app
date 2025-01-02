import 'package:minapp/features/host/features/properties/domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  CityModel({required String city}) : super(city: city);

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(city: json['city']);
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
    };
  }
}
