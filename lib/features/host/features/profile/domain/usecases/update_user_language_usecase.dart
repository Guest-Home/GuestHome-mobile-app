
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';

import '../../../../../../service_locator.dart';

class UpdateUserLanguageUseCase extends UseCase<Either<Failure,bool>,FormData>{
  @override
  Future<Either<Failure, bool>> call(FormData param)async{
    return await sl<UserProfileRepository>().updateUserLanguage(param);
  }

}