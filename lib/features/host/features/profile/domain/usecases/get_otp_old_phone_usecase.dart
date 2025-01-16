

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/auth/domain/entities/otp_response_entity.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';

import '../../../../../../service_locator.dart';

class GetOtpOldPhoneUseCase extends UseCaseWithOutProp<Either<Failure,OtpResponseEntity>>{
  @override
  Future<Either<Failure, OtpResponseEntity>> call()async{
    return await sl<UserProfileRepository>().getOtpForOld();
  }

}