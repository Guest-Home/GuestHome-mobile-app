import 'package:dartz/dartz.dart';
import 'package:minapp/features/host/features/properties/data/datasources/property_api_data_source.dart';
import 'package:minapp/features/host/features/properties/data/models/property_type_model.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_type_repository.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../core/error/failure.dart';

class PropertyTypeRepositoryImpl implements PropertyTypeRepository {
  @override
  Future<Either<Failure, List<PropertyTypeModel>>> getPropertyType() async {
    return await sl<PropertyApiDataSource>().getPropertiesType();
  }
}
