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
  Future<Either<Failure, ReservationModel>> getReservation();
  Future<Either<Failure, bool>> acceptReservation(int id);
  Future<Either<Failure, bool>> rejectReservation(int id);
}

class ReservationApiDataSourceImpl implements ReservationApiDataSource {
  @override
  Future<Either<Failure, ReservationModel>> getReservation() async {
    try {
      final response = await sl<DioClient>().get(ApiUrl.reservations);
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
  Future<Either<Failure, bool>> acceptReservation(int id) async {
    try {
      final response =
          await sl<DioClient>().put("${ApiUrl.acceptReservations}$id/");
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['msg']!));
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
      return Left(ServerFailure(e.response!.data['msg']!));
    }
  }
}
