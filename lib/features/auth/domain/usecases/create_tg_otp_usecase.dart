import 'package:dartz/dartz.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/useCases/use_case.dart';
import '../../../../service_locator.dart';
import '../entities/otp_response_entity.dart';

class CreateTgOtpUsecase
    extends UseCase<Either<Failure, OtpResponseEntity>, Map<String, dynamic>> {
  @override
  Future<Either<Failure, OtpResponseEntity>> call(
      Map<String, dynamic> param) async {
    return await sl<OtpRepository>().createTgOtp(param);
  }
}
