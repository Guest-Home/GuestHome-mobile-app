

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/request/data/models/reservation_model.dart';
import 'package:minapp/features/host/features/request/domain/entities/reservation_entity.dart';
import 'package:minapp/features/host/features/request/domain/repositories/reservation_repository.dart';

import '../../../../../../service_locator.dart';

class GetRservationUseCase extends UseCaseWithOutProp<Either<Failure,ReservationModel>>{
  @override
  Future<Either<Failure, ReservationModel>> call()async{
    return await sl<ReservationRepository>().getReservation();
  }
}