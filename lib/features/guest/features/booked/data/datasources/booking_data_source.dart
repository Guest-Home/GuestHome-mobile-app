

import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/guest/features/booked/data/models/my_booking_model.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';

abstract class BookingDataSource{
  Future<Either<Failure,MyBookingModel>> getMyBookings();
  Future<Either<Failure,bool>> cancelMyBookings(int id);


}

class BookingDataSourceImpl extends BookingDataSource{
  @override
  Future<Either<Failure, MyBookingModel>> getMyBookings()async{
    try {
      final response = await sl<DioClient>().get(ApiUrl.propertyBooking);
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
      return Left(ServerFailure(e.response!.data.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelMyBookings(int id)async{

    try {
    final response = await sl<DioClient>().put("${ApiUrl.propertyBooking}$id/");
    if (response.statusCode == 200) {
    return Right(true);
    } else {
    return Left(ServerFailure(response.data['error']));
    }
    } on DioException catch (e) {
    return Left(ServerFailure(e.response!.data.toString()));
    }
  }

}