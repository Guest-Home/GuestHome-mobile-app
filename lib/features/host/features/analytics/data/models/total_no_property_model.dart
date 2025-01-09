

import '../../domain/entities/total_no_property_entity.dart';

class TotalNumberOfPropertyModel extends TotalNumberOfPropertyEntity {
  TotalNumberOfPropertyModel({
    int? totalNumberOfProperty,
  }):super(
    totalNumberOfProperty: totalNumberOfProperty!
  );

  factory TotalNumberOfPropertyModel.fromMap(Map<String, dynamic> json) => TotalNumberOfPropertyModel(
    totalNumberOfProperty: json["total_number_of_property"],
  );

}