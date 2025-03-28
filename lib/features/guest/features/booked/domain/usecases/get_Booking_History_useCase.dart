
import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/useCases/use_case.dart';
import '../../../../../../service_locator.dart';
import '../entities/my_booking_entity.dart';
import '../repositories/my_booking_repositorty.dart';

class GetBookingHistoryUsecase extends UseCase<Either<Failure,MyBookingEntity>,String>{
  @override
  Future<Either<Failure, MyBookingEntity>> call(param)async{
    return await sl<MyBookingRepository>().getBookingHistory(param);
  }

}