

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/guest/features/booked/domain/repositories/my_booking_repositorty.dart';

import '../../../../../../service_locator.dart';

class CancelBookingUseCase extends UseCase<Either<Failure,bool>,int>{
  @override
  Future<Either<Failure, bool>> call(int param)async{
    return await sl<MyBookingRepository>().cancelMyBookings(param);
  }

}