import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/properties/data/datasources/property_api_data_source.dart';
import 'package:minapp/features/host/features/properties/domain/entities/amenity_entity.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/amenity_repository.dart';
import 'package:minapp/service_locator.dart';

class AmenityRepositoryImpl implements AmenityRepository {
  @override
  Future<Either<Failure, List<AmenityEntity>>> getAmenity() async {
    return await sl<PropertyApiDataSource>().getAmenity();
  }
}
