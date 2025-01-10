import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/properties/data/datasources/property_api_data_source.dart';
import 'package:minapp/features/host/features/properties/data/models/property_model.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_repository.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/create_property_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/update_property_usecase.dart';

import '../../../../../../service_locator.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  @override
  Future<Either<Failure, List<PropertyModel>>> getProperties() async {
    return await sl<PropertyApiDataSource>().getProperties();
  }

  @override
  Future<Either<Failure, bool>> createProperty(
      CreatePropertyParam param) async {
    return await sl<PropertyApiDataSource>().createProperty(param);
  }

  @override
  Future<Either<Failure, bool>> deleteProperty(int id) async {
    return await sl<PropertyApiDataSource>().deleteProperty(id);
  }

  @override
  Future<Either<Failure, bool>> updateProperty(UpdatePropertyParam param)async{
    return await sl<PropertyApiDataSource>().updateProperty(param);

  }
}
