


import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/total_no_property_entity.dart';
import 'package:minapp/features/host/features/analytics/domain/repositories/analytics_repository.dart';

import '../../../../../../service_locator.dart';

class GetTotalPropertyUsecase extends UseCaseWithOutProp<Either<Failure,TotalNumberOfPropertyEntity>>{
  @override
  Future<Either<Failure, TotalNumberOfPropertyEntity>> call()async{
    return sl<AnalyticsRepository>().getTotalProperty();
  }

}