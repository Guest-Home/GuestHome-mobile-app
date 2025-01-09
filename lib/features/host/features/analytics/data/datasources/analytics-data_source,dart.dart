

import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/host/features/analytics/data/models/custom_occupancy_rate_model.dart';
import 'package:minapp/features/host/features/analytics/data/models/occupancy_raate_model.dart';
import 'package:minapp/features/host/features/analytics/data/models/total_no_property_model.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';

abstract class AnalyticsDataSource{
  Future<Either<Failure,OccupancyRateModel>> getOccupancyRate();
  Future<Either<Failure,TotalNumberOfPropertyModel>> getTotalProperty();
  Future<Either<Failure,CustomOccupancyRateModel>> getCustomOccupancyRate(Map<String,dynamic> dates);



}
class AnalyticsDataSourceImpl extends AnalyticsDataSource{
  @override
  Future<Either<Failure, OccupancyRateModel>> getOccupancyRate()async{
    try {
      final response = await sl<DioClient>().get(ApiUrl.occupancyRate);
      if (response.statusCode == 200) {
        final occupancyRate = await Isolate.run(
              () {
            return OccupancyRateModel.fromJson(response.data);
          },
        );
        return Right(occupancyRate);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TotalNumberOfPropertyModel>> getTotalProperty()async{
    try {
      final response = await sl<DioClient>().get(ApiUrl.totalProperty);
      if (response.statusCode == 200) {
        final totalProperty = await Isolate.run(
              () {
            return TotalNumberOfPropertyModel.fromMap(response.data);
          },
        );
        return Right(totalProperty);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomOccupancyRateModel>> getCustomOccupancyRate(Map<String,dynamic> dates)async{
    final startDate=dates['startDate'];
    final endDate=dates['endDate'];
    print("////");
    print(startDate);
    print(endDate);
    try {
      final response = await sl<DioClient>().get("${ApiUrl.occupancyRate}?start_date=$startDate&end_date=$endDate");
      if (response.statusCode == 200) {
        final occupancyRate = await Isolate.run(
              () {
            return CustomOccupancyRateModel.fromMap(response.data);
          },
        );
        return Right(occupancyRate);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}