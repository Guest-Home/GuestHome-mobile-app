import 'package:dartz/dartz.dart';
import 'package:minapp/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/useCases/use_case.dart';
import '../../../../service_locator.dart';

class VerifyTgOtpUsecase
    extends UseCase<Either<Failure, VerifyOtpEntity>, Map<String, dynamic>> {
  @override
  Future<Either<Failure, VerifyOtpEntity>> call(
      Map<String, dynamic> param) async {
    return await sl<OtpRepository>().verifyTgOtp(param);
  }
}
