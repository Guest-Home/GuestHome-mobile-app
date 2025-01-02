import 'package:dartz/dartz.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/city_repository.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../core/error/failure.dart';
import '../entities/city_entity.dart';

class GetCitiesUsecase
    extends UseCaseWithOutProp<Either<Failure, List<CityEntity>>> {
  @override
  Future<Either<Failure, List<CityEntity>>> call() async {
    return await sl<CityRepository>().getCities();
  }
}
