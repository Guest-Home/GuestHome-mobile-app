
import 'package:dartz/dartz.dart';
import 'package:minapp/core/useCases/use_case.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../service_locator.dart';
import '../repositories/user_profile_repository.dart';

class UpdateUserProfileUseCase extends UseCase<Either<Failure,bool>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, bool>> call(param)async{
    return await sl<UserProfileRepository>().updateUserProfile(param);
  }

}