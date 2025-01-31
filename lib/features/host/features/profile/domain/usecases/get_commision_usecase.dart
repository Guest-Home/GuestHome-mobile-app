

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/profile/domain/entities/platform_commission_entity.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';

import '../../../../../../service_locator.dart';

class GetCommissionUseCase extends UseCaseWithOutProp<Either<Failure,PlatformCommissionEntity>>{
  @override
  Future<Either<Failure, PlatformCommissionEntity>> call()async{
    return await sl<UserProfileRepository>().getPlatformCommission();
  }

}