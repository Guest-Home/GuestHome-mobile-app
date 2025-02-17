import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/core/error/error_response.dart';
import 'package:minapp/service_locator.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../domain/entities/g_property_entity.dart';
import '../models/g_property_model.dart';
import '../models/guest_property_model.dart';

abstract class HouseDataSource {
  Future<Either<Failure, GuestPropertyModel>> getPropertyByType(String name);
  Future<Either<Failure, GpropertyEntity>> getPopularProperty(String? url);
  Future<Either<Failure, bool>> bookingProperty(Map<String, dynamic> bookData);
  Future<Either<Failure, GuestPropertyModel>> filterProperty(
      Map<String, dynamic> filterData);
  Future<Either<Failure, GuestPropertyModel>> filterNextProperty(Map<String,dynamic> filterData);
}

class HouseDataSourceImpl implements HouseDataSource {
  @override
  Future<Either<Failure, GuestPropertyModel>> getPropertyByType(String name) async {
    try {
      final response =name.contains(ApiUrl.baseUrl)?await sl<DioClient>().get(name.substring(ApiUrl.baseUrl.length)):
          await sl<DioClient>().get("${ApiUrl.propertyByType}?category=$name");
      if (response.statusCode == 200) {
        final properties = await Isolate.run(
          () {
            return GuestPropertyModel.fromMap(response.data);
            // GpropertyModel.fromMap(response.data);
          },
        );
        return Right(properties);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, GpropertyEntity>> getPopularProperty(String? url) async {
    try {
      final response =url!.isNotEmpty?await sl<DioClient>().get(url.substring(ApiUrl.baseUrl.length)): await sl<DioClient>().get(ApiUrl.tradingProperty);
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
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> bookingProperty(
      Map<String, dynamic> bookData) async {
    try {
      final response =
          await sl<DioClient>().post(ApiUrl.propertyBooking, data: bookData);
      if (response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, GuestPropertyModel>> filterProperty(
      Map<String, dynamic> filterData) async {
    try {
      print(filterData);
      final response =
          await sl<DioClient>().post(ApiUrl.filterProperties, data: filterData);
      if (response.statusCode == 200) {
        final properties = await Isolate.run(
          () {
            return GuestPropertyModel.fromMap(response.data);
          },
        );
        return Right(properties);
      } else {
        return Left(ServerFailure(response.data['msg']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['msg'] ?? "".toString()));
    }
  }

  @override
  Future<Either<Failure, GuestPropertyModel>> filterNextProperty(Map<String,dynamic> filterData)async{
    try {
      final url=filterData['url'];
      Map<String, dynamic> dataItem = Map.from(filterData)..remove("url");
      final response =
          await sl<DioClient>().post(url!.substring(ApiUrl.baseUrl.length),data: dataItem);
      if (response.statusCode == 200) {
        final properties = await Isolate.run(
              () {
            return GuestPropertyModel.fromMap(response.data);
          },
        );
        return Right(properties);
      } else {
        return Left(ServerFailure(response.data['msg']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['msg'] ?? "".toString()));
    }
  }
}
