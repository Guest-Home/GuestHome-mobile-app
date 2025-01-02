import 'package:dartz/dartz.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/amenity_repository.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../core/error/failure.dart';
import '../entities/amenity_entity.dart';

class GetAmenityUsecase
    extends UseCaseWithOutProp<Either<Failure, List<AmenityEntity>>> {
  @override
  Future<Either<Failure, List<AmenityEntity>>> call() async {
    return await sl<AmenityRepository>().getAmenity();
  }
}
