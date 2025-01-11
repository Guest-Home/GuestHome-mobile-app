import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';

abstract class HouseRepository {
  Future<Either<Failure, GpropertyEntity>> getPropertyByType(String name);
}
