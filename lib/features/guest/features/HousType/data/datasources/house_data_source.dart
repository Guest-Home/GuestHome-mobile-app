import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/guest/features/HousType/data/models/g_property_model.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';

abstract class HouseDataSource {
  Future<Either<Failure, GpropertyModel>> getPropertyByType(String name);
  Future<Either<Failure, GpropertyModel>> getPopularProperty();

}

class HouseDataSourceImpl implements HouseDataSource {
  @override
  Future<Either<Failure, GpropertyModel>> getPropertyByType(String name) async {
    try {
      final response = await sl<DioClient>().get("${ApiUrl.propertyByType}?category=$name");
      if (response.statusCode == 200) {
        final properties = await Isolate.run(
          () {
            return gpropertyModelFromMap(response.data);
            // GpropertyModel.fromMap(response.data);
          },
        );
        return Right(properties);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data.toString()));
    }
  }

  @override
  Future<Either<Failure, GpropertyModel>> getPopularProperty()async{
    try {
      final response = await sl<DioClient>().get(ApiUrl.tradingProperty);
      if (response.statusCode == 200) {
        final properties = await Isolate.run(
              () {
            return gpropertyModelFromMap(response.data);
          },
        );
        return Right(properties);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data.toString()));
    }
  }
}
