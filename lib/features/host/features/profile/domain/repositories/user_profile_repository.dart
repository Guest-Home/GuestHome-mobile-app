
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/profile/domain/entities/platform_commission_entity.dart';
import 'package:minapp/features/host/features/profile/domain/entities/user_profile_entity.dart';
import '../../../../../auth/domain/entities/otp_response_entity.dart';

abstract class UserProfileRepository{
  Future<Either<Failure,UserProfileEntity>> getUserProfile();
  Future<Either<Failure,bool>> updateUserProfile(Map<String,dynamic> userData);
  Future<Either<Failure,OtpResponseEntity>> getOtpForOld();
  Future<Either<Failure, String>> verifyOldOtp(Map<String,dynamic> userData);
  Future<Either<Failure, String>> verifyNewOtp(Map<String,dynamic> userData);
  Future<Either<Failure,OtpResponseEntity>> getOtpForNew(Map<String,dynamic> userData);

  Future<Either<Failure,bool>> deposit(Map<String,dynamic> data);
  Future<Either<Failure,PlatformCommissionEntity>> getPlatformCommission();
}