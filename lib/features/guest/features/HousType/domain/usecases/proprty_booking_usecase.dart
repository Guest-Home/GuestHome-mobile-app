


import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/guest/features/HousType/domain/repositories/house_repository.dart';

import '../../../../../../service_locator.dart';

class PropertyBookingUseCase extends UseCase<Either<Failure,bool>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> param)async{
    return await sl<HouseRepository>().bookingProperty(param);

  }

}