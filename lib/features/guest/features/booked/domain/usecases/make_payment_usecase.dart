
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/guest/features/booked/domain/repositories/my_booking_repositorty.dart';

import '../../../../../../service_locator.dart';

class MakePaymentUseCase extends UseCase<Either<Failure,bool>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> param)async{
    return await sl<MyBookingRepository>().makePayment(param);
  }

}