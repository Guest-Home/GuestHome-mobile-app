import 'package:dartz/dartz.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/create_property_usecase.dart';

import '../../../../../../core/error/failure.dart';
import '../entities/property_entity.dart';

abstract class PropertyRepository {
  Future<Either<Failure, List<PropertyEntity>>> getProperties();
  // Future<Either<Failure, Property>> getProperty(String id);
  Future<Either<Failure, bool>> createProperty(CreatePropertyParam param);
  // Future<Either<Failure, Property>> updateProperty(Property property);
  // Future<Either<Failure, Property>> deleteProperty(String id);
}
