import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';
import 'package:minapp/service_locator.dart';

import '../../../../core/error/failure.dart';

class VerifyOtpUsecase
    extends UseCase<Either<Failure, VerifyOtpEntity>, VerifyOtpParams> {
  @override
  Future<Either<Failure, VerifyOtpEntity>> call(VerifyOtpParams param) async {
    return await sl<OtpRepository>().verifyOtp(param);
  }
}

class VerifyOtpParams extends Equatable {
  final String phoneNumber;
  final String otp;
  const VerifyOtpParams({
    required this.phoneNumber,
    required this.otp,
  });

  @override
  List<Object> get props => [phoneNumber, otp];
}
