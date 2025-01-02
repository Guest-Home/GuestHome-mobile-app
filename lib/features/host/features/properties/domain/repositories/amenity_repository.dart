import 'package:dartz/dartz.dart';
import 'package:minapp/features/host/features/properties/domain/entities/amenity_entity.dart';

import '../../../../../../core/error/failure.dart';

abstract class AmenityRepository {
  Future<Either<Failure, List<AmenityEntity>>> getAmenity();
}
