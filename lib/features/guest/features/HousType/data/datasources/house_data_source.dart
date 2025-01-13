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
  Future<Either<Failure, bool>> bookingProperty(Map<String,dynamic> bookData);
  Future<Either<Failure, GpropertyModel>> filterProperty(Map<String,dynamic> filterData);



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

  @override
  Future<Either<Failure, bool>> bookingProperty(Map<String, dynamic> bookData)async{
    try {
      final response = await sl<DioClient>().post(ApiUrl.propertyBooking,data: bookData);
      if (response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data.toString()));
    }

  }

  @override
  Future<Either<Failure, GpropertyModel>> filterProperty(Map<String, dynamic> filterData)async{
    try {
      final response = await sl<DioClient>().post(ApiUrl.filterProperties,data: filterData);
      if (response.statusCode == 200) {
        final properties = await Isolate.run(
              () {
            return gpropertyModelFromMap(response.data);
          },
        );
        return Right(properties);
      } else {
        return Left(ServerFailure(response.data['msg']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['msg']??"".toString()));
    }
  }
}
