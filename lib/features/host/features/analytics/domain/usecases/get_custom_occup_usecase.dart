
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/custom_occupancy_rate_entity.dart';
import 'package:minapp/features/host/features/analytics/domain/repositories/analytics_repository.dart';

import '../../../../../../service_locator.dart';

class GetCustomOccupancyUseCase extends UseCase<Either<Failure,CustomOccupancyEntity>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, CustomOccupancyEntity>> call(Map<String, dynamic> param)async{
    return await sl<AnalyticsRepository>().getCustomOccupancyRate(param);
  }

}