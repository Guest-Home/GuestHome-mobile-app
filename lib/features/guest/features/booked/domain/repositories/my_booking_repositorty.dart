

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_detail.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_entity.dart';

abstract class MyBookingRepository{
  Future<Either<Failure,MyBookingEntity>> getMyBookings(String url);
  Future<Either<Failure,bool>> cancelMyBookings(int id);
  Future<Either<Failure,BookedDetailEntity>> getMyBooking(int id);
}