import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/guest/features/booked/data/models/my_booking_detail_model.dart';
import 'package:minapp/features/guest/features/booked/data/models/my_booking_model.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/error_response.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';

abstract class BookingDataSource {
  Future<Either<Failure, MyBookingModel>> getMyBookings(String url);
  Future<Either<Failure, bool>> cancelMyBookings(int id);
  Future<Either<Failure, BookedDetailModel>> getMyBooking(int id);
  Future<Either<Failure,bool>> makePayment(Map<String,dynamic> data);

}

class BookingDataSourceImpl extends BookingDataSource {
  @override
  Future<Either<Failure, MyBookingModel>> getMyBookings(String url) async {
    try {
      final response =url.isNotEmpty?await sl<DioClient>().get(url.substring(ApiUrl.baseUrl.length)):await sl<DioClient>().get(ApiUrl.propertyBooking);
      if (response.statusCode == 200) {
        final booking = await Isolate.run(
          () {
            return MyBookingModel.fromMap(response.data);
          },
        );
        return Right(booking);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelMyBookings(int id) async {
    try {
      final response = await sl<DioClient>().put("${ApiUrl.cancelBooking}$id/");
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, BookedDetailModel>> getMyBooking(int id) async {
    try {
      final response =
          await sl<DioClient>().get("${ApiUrl.propertyBooking}detail/$id/");
      if (response.statusCode == 200) {
        final booking = await Isolate.run(
          () {
            return BookedDetailModel.fromMap(response.data);
          },
        );
        return Right(booking);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> makePayment(Map<String, dynamic> data)async{
    final id=data["id"];
    Map<String, dynamic> newData = Map.fromEntries(
      data.entries.where((entry) => entry.key != 'id'),
    );

    try {
      final response = await sl<DioClient>().post("${ApiUrl.reservationPayment}$id/",data: newData);
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['Error']));
    }
  }
}
