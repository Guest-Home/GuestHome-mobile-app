import 'package:dartz/dartz.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_repository.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../core/error/failure.dart';
import '../entities/property_entity.dart';

class GetPropertiesUsecase
    extends UseCaseWithOutProp<Either<Failure, List<PropertyEntity>>> {
  @override
  Future<Either<Failure, List<PropertyEntity>>> call() async {
    return await sl<PropertyRepository>().getProperties();
  }
}
