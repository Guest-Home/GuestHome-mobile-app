

import 'package:dartz/dartz.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../guest/features/HousType/domain/entities/guest_property_entity.dart';
import '../../../host/features/properties/domain/entities/property_entity.dart';

abstract class SearchRepository{
  Future<Either<Failure,GuestPropertyEntity>> searchProperty(String name);
  Future<Either<Failure,List<PropertyEntity>>> hostSearchProperty(String name);

}