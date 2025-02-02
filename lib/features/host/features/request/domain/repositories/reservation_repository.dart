

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/request/data/models/reservation_model.dart';

abstract class ReservationRepository{
  Future<Either<Failure,ReservationModel>> getReservation(String url);
  Future<Either<Failure,bool>> acceptReservation(int id);
  Future<Either<Failure,bool>> rejectReservation(int id);

}