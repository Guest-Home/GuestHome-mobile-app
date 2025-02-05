import 'dart:isolate';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/host/features/request/data/models/reservation_model.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/error_response.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';

abstract class ReservationApiDataSource {
  Future<Either<Failure, ReservationModel>> getReservation(String url);
  Future<Either<Failure, bool>> acceptReservation(Map<String,dynamic> data);
  Future<Either<Failure, bool>> rejectReservation(int id);
}

class ReservationApiDataSourceImpl implements ReservationApiDataSource {
  @override
  Future<Either<Failure, ReservationModel>> getReservation(String url) async {
    try {
      final response =url.isNotEmpty?await sl<DioClient>().get(url.substring(ApiUrl.baseUrl.length)): await sl<DioClient>().get(ApiUrl.reservations);
      if (response.statusCode == 200) {
        final reservation = await Isolate.run(
          () {
            return reservationFromMap(response.data);
          },
        );
        return Right(reservation);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> acceptReservation(Map<String,dynamic> data) async {
    try {
      int id=data['id'];
      Map<String,dynamic> roomNo={
        "room_number":data['room_number']
      };
      final response =
          await sl<DioClient>().put("${ApiUrl.acceptReservations}$id/",data: roomNo);
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['error'].toString()));

    }
  }

  @override
  Future<Either<Failure, bool>> rejectReservation(int id) async {
    try {
      final response =
          await sl<DioClient>().put("${ApiUrl.rejectReservations}$id/");
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['error'].toString()));
    }
  }
}
