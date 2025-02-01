

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_entity.dart';
import 'package:minapp/features/guest/features/booked/domain/repositories/my_booking_repositorty.dart';

import '../../../../../../service_locator.dart';

class GetMyBookingUseCase extends UseCase<Either<Failure,MyBookingEntity>,String>{
  @override
  Future<Either<Failure, MyBookingEntity>> call(param)async{
    return await sl<MyBookingRepository>().getMyBookings(param);
  }

}