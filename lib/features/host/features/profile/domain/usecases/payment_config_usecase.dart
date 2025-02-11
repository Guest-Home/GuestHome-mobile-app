

import 'package:dartz/dartz.dart';
import 'package:minapp/core/useCases/use_case.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../service_locator.dart';
import '../repositories/user_profile_repository.dart';

class PaymentConfigUseCase extends UseCase<Either<Failure,bool>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> param)async{
    return await sl<UserProfileRepository>().paymentConfig(param);

  }


}