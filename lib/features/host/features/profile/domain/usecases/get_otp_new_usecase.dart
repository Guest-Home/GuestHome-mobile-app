

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';

import '../../../../../../service_locator.dart';
import '../../../../../auth/domain/entities/otp_response_entity.dart';

class GetOtpForNewUseCase extends UseCase<Either<Failure,OtpResponseEntity>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, OtpResponseEntity>> call(Map<String, dynamic> param)async{
   return await sl<UserProfileRepository>().getOtpForNew(param);
  }

}