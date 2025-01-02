import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/properties/domain/entities/city_entity.dart';

abstract class CityRepository {
  Future<Either<Failure, List<CityEntity>>> getCities();
}
