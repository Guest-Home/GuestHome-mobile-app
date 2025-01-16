
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';

import '../../../../../../service_locator.dart';

class VerifyOldOtpUseCase extends UseCase<Either<Failure,String>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, String>> call(Map<String, dynamic> param)async{
    return await sl<UserProfileRepository>().verifyOldOtp(param);
  }

}