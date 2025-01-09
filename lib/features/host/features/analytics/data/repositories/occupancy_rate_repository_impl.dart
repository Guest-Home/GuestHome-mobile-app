
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/analytics/data/datasources/analytics-data_source,dart.dart';
import 'package:minapp/features/host/features/analytics/data/models/custom_occupancy_rate_model.dart';
import 'package:minapp/features/host/features/analytics/data/models/occupancy_raate_model.dart';
import 'package:minapp/features/host/features/analytics/data/models/total_no_property_model.dart';
import 'package:minapp/features/host/features/analytics/domain/repositories/analytics_repository.dart';

import '../../../../../../service_locator.dart';

class OccupancyRateRepositoryImpl implements AnalyticsRepository{
  @override
  Future<Either<Failure, OccupancyRateModel>> getOccupancyRate()async{
    return await sl<AnalyticsDataSource>().getOccupancyRate();
  }

  @override
  Future<Either<Failure, TotalNumberOfPropertyModel>> getTotalProperty()async{
    return await sl<AnalyticsDataSource>().getTotalProperty();

  }

  @override
  Future<Either<Failure, CustomOccupancyRateModel>> getCustomOccupancyRate(Map<String,dynamic> dates)async{
    return await sl<AnalyticsDataSource>().getCustomOccupancyRate(dates);

  }

}