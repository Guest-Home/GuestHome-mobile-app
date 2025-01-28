import 'package:dartz/dartz.dart';
import 'package:minapp/features/auth/domain/entities/customer_profile_entity.dart';
import 'package:minapp/features/auth/domain/entities/otp_response_entity.dart';
import 'package:minapp/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:minapp/features/auth/domain/usecases/create_customer_profile_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/create_otp_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/verify_otp_usecase.dart';

import '../../../../core/error/failure.dart';

abstract class OtpRepository {
  Future<Either<Failure, OtpResponseEntity>> createOtp(CreateOtpParams params);
  Future<Either<Failure, OtpResponseEntity>> createTgOtp(
      Map<String, dynamic> data);

  Future<Either<Failure, VerifyOtpEntity>> verifyOtp(VerifyOtpParams params);
  Future<Either<Failure, VerifyOtpEntity>> verifyTgOtp(
      Map<String, dynamic> data);
  Future<Either<Failure, CustomerProfileEntity>> createCustomerProfile(
      CreateCustomerParams params);
  Future<Either<Failure, String>> logOut(Map<String, dynamic> data);
  Future<Either<Failure, String>> deactivateAccount(Map<String, dynamic> data);
}
