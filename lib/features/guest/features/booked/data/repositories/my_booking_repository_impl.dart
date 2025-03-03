


import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/booked/data/datasources/booking_data_source.dart';
import 'package:minapp/features/guest/features/booked/data/models/my_booking_model.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_detail.dart';
import 'package:minapp/features/guest/features/booked/domain/repositories/my_booking_repositorty.dart';

import '../../../../../../service_locator.dart';

class MyBookingRepositoryImpl implements MyBookingRepository{
  @override
  Future<Either<Failure, MyBookingModel>> getMyBookings(String url)async{
    return await sl<BookingDataSource>().getMyBookings(url);
  }

  @override
  Future<Either<Failure, bool>> cancelMyBookings(int id)async{
    return await sl<BookingDataSource>().cancelMyBookings(id);
  }

  @override
  Future<Either<Failure, BookedDetailEntity>> getMyBooking(int id)async{
    return await sl<BookingDataSource>().getMyBooking(id);
  }

  @override
  Future<Either<Failure, bool>> makePayment(Map<String, dynamic> data)async{
    return await sl<BookingDataSource>().makePayment(data);
  }

}