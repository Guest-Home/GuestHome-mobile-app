

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../host/features/properties/domain/entities/property_entity.dart';

abstract class SearchRepository{
  Future<Either<Failure,List<PropertyEntity>>> searchProperty(String name);
  Future<Either<Failure,List<PropertyEntity>>> hostSearchProperty(String name);

}