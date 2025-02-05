import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/guest_property_entity.dart';

abstract class HouseRepository {
  Future<Either<Failure, GuestPropertyEntity>> getPropertyByType(String name);
  Future<Either<Failure, GpropertyEntity>> getPopularProperty(String? url);
  Future<Either<Failure, bool>> bookingProperty(Map<String,dynamic> bookData);
  Future<Either<Failure, GuestPropertyEntity>> filterProperty(Map<String,dynamic> filterData);
  Future<Either<Failure, GuestPropertyEntity>> filterNextProperty(Map<String,dynamic> filterData);
}
