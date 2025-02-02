import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/request/data/datasources/reservation_remote_api.dart';
import 'package:minapp/features/host/features/request/data/models/reservation_model.dart';
import 'package:minapp/features/host/features/request/domain/repositories/reservation_repository.dart';

import '../../../../../../service_locator.dart';

class ReservationRepositoryImpl implements ReservationRepository{
  @override
  Future<Either<Failure, ReservationModel>> getReservation(String url)async {
    return await sl<ReservationApiDataSource>().getReservation(url);
  }

  @override
  Future<Either<Failure, bool>> acceptReservation(int id)async{
    return  sl<ReservationApiDataSource>().acceptReservation(id);
  }

  @override
  Future<Either<Failure, bool>> rejectReservation(int id) {
    return  sl<ReservationApiDataSource>().rejectReservation(id);
  }

}