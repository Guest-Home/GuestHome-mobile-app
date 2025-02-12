
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/host/features/profile/domain/entities/payment_config_entity.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';

import '../../../../../../service_locator.dart';

class GetPaymentConfigUseCase extends UseCaseWithOutProp<Either<Failure,PaymentConfigEntity>>{
  @override
  Future<Either<Failure, PaymentConfigEntity>> call() async{
    return await sl<UserProfileRepository>().getPaymentConfig();
  }

}