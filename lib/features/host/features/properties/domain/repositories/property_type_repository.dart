import 'package:dartz/dartz.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_type_entity.dart';

import '../../../../../../core/error/failure.dart';

abstract class PropertyTypeRepository {
  Future<Either<Failure, List<PropertyTypeEntity>>> getPropertyType();
}
