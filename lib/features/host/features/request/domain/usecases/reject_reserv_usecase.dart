
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';

import '../../../../../../service_locator.dart';
import '../repositories/reservation_repository.dart';

class RejecctReservationUseCase extends UseCase<Either<Failure,bool>,int>{
  @override
  Future<Either<Failure, bool>> call(int param)async{
    return await sl<ReservationRepository>().acceptReservation(param);
  }
  
}