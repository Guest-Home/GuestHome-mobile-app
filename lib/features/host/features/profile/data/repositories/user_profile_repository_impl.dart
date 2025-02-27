
import 'package:dartz/dartz.dart';
import 'package:dio/src/form_data.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/auth/data/models/otp_response_model.dart';
import 'package:minapp/features/host/features/profile/data/models/payment_config_model.dart';
import 'package:minapp/features/host/features/profile/data/datasources/user_proile_datasource.dart';
import 'package:minapp/features/host/features/profile/data/models/deposit_transaction_model.dart';
import 'package:minapp/features/host/features/profile/data/models/platform_commission_model.dart';
import 'package:minapp/features/host/features/profile/data/models/user_profile_model.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';
import '../../../../../../service_locator.dart';

class UserProfileRepositoryImple implements UserProfileRepository{
  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile()async{
    return await sl<UserProfileDataSource>().getUserProfile();
  }

  @override
  Future<Either<Failure, bool>> updateUserProfile(Map<String,dynamic> userData)async{
    return await sl<UserProfileDataSource>().updateUserProfile(userData);
  }

  @override
  Future<Either<Failure, OtpResponseModel>> getOtpForOld()async{
    return await sl<UserProfileDataSource>().getOtpForOld();
  }

  @override
  Future<Either<Failure, String>> verifyOldOtp(Map<String, dynamic> userData)async{
    return await sl<UserProfileDataSource>().verifyOldOtp(userData);
  }

  @override
  Future<Either<Failure, OtpResponseModel>> getOtpForNew(Map<String, dynamic> userData)async{
    return await sl<UserProfileDataSource>().getOtpForNew(userData);
  }

  @override
  Future<Either<Failure, String>> verifyNewOtp(Map<String, dynamic> userData)async{
    return await sl<UserProfileDataSource>().verifyNewOtp(userData);
  }

  @override
  Future<Either<Failure, bool>> deposit(Map<String, dynamic> data)async{
    return await sl<UserProfileDataSource>().deposit(data);
  }

  @override
  Future<Either<Failure, PlatformCommissionModel>> getPlatformCommission()async{
    return await  sl<UserProfileDataSource>().getPlatformCommission();
  }

  @override
  Future<Either<Failure, DepositTransactionModel>> getDepositTransaction(String url)async{
    return await  sl<UserProfileDataSource>().getDepositTransaction(url);
  }

  @override
  Future<Either<Failure, bool>> paymentConfig(Map<String, dynamic> config)async{
    return await  sl<UserProfileDataSource>().paymentConfig(config);
  }

  @override
  Future<Either<Failure, PaymentConfigModel>> getPaymentConfig()async{
    return await  sl<UserProfileDataSource>().getPaymentConfig();
  }

  @override
  Future<Either<Failure, bool>> updateUserLanguage(FormData formdata)async{
    return await  sl<UserProfileDataSource>().updateUserLanguage(formdata);

  }

}