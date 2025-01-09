

import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/host/features/analytics/data/models/occupancy_raate_model.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';

abstract class AnalyticsDataSource{
  Future<Either<Failure,OccupancyRateModel>> getOccupancyRate();

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

}