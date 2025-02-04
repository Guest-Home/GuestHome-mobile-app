import 'package:dartz/dartz.dart';
import 'package:minapp/features/host/features/profile/domain/entities/deposit_transaction_model.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/useCases/use_case.dart';
import '../../../../../../service_locator.dart';
import '../repositories/user_profile_repository.dart';

class GetDepositTransactionUsecase extends UseCase<Either<Failure,DepositTransactionEntity>,String>{
  @override
  Future<Either<Failure, DepositTransactionEntity>> call(param)async{
    return await sl<UserProfileRepository>().getDepositTransaction(param);
  }

}