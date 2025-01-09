

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/custom_occupancy_rate_entity.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/occupancy_rate_entity.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/total_no_property_entity.dart';

abstract class AnalyticsRepository{
  Future<Either<Failure,OccupancyRateEntity>> getOccupancyRate();
  Future<Either<Failure,TotalNumberOfPropertyEntity>> getTotalProperty();
  Future<Either<Failure,CustomOccupancyEntity>> getCustomOccupancyRate(Map<String,dynamic> dates);
}