import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';

abstract class HouseRepository {
  Future<Either<Failure, GpropertyEntity>> getPropertyByType(String name);
  Future<Either<Failure, GpropertyEntity>> getPopularProperty();
  Future<Either<Failure, bool>> bookingProperty(Map<String,dynamic> bookData);
  Future<Either<Failure, GpropertyEntity>> filterProperty(Map<String,dynamic> filterData);
}
