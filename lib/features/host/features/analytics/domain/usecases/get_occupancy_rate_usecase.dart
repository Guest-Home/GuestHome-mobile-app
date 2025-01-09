

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/occupancy_rate_entity.dart';
import 'package:minapp/features/host/features/analytics/domain/repositories/analytics_repository.dart';

import '../../../../../../service_locator.dart';

class GetOccupancyRateUseCase extends UseCaseWithOutProp<Either<Failure,OccupancyRateEntity>>{
  @override
  Future<Either<Failure, OccupancyRateEntity>> call()async{
    return await sl<AnalyticsRepository>().getOccupancyRate();
  }

}