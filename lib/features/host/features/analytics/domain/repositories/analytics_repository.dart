

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/analytics/domain/entities/occupancy_rate_entity.dart';

abstract class AnalyticsRepository{
  Future<Either<Failure,OccupancyRateEntity>> getOccupancyRate();
}