

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_detail.dart';
import 'package:minapp/features/guest/features/booked/domain/repositories/my_booking_repositorty.dart';

import '../../../../../../service_locator.dart';

class GetBookingDetailUseCase extends UseCase<Either<Failure,BookedDetailEntity>,int>{
  @override
  Future<Either<Failure, BookedDetailEntity>> call(int param)async{
    return await sl<MyBookingRepository>().getMyBooking(param);
  }

}