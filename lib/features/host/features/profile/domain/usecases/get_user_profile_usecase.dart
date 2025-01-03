
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/profile/domain/entities/user_profile_entity.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';

import '../../../../../../service_locator.dart';

class GetUserProfileUseCase extends UseCaseWithOutProp<Either<Failure,UserProfileEntity>>{
  @override
  Future<Either<Failure, UserProfileEntity>> call()async{
    return await sl<UserProfileRepository>().getUserProfile();
  }




}