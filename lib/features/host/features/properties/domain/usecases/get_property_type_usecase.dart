import 'package:dartz/dartz.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_type_entity.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_type_repository.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../core/error/failure.dart';

class GetPropertyTypeUsecase
    extends UseCaseWithOutProp<Either<Failure, List<PropertyTypeEntity>>> {
  @override
  Future<Either<Failure, List<PropertyTypeEntity>>> call() async {
    return await sl<PropertyTypeRepository>().getPropertyType();
  }
}
