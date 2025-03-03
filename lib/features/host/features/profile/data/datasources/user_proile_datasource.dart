import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/auth/data/models/otp_response_model.dart';
import 'package:minapp/features/host/features/profile/data/models/deposit_transaction_model.dart';
import 'package:minapp/features/host/features/profile/data/models/payment_config_model.dart';
import 'package:minapp/features/host/features/profile/data/models/platform_commission_model.dart';
import 'package:minapp/features/host/features/profile/data/models/user_profile_model.dart';
import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/error_response.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';

abstract class UserProfileDataSource {
  Future<Either<Failure,bool>> paymentConfig(Map<String,dynamic> config);
  Future<Either<Failure,PaymentConfigModel>> getPaymentConfig();

  Future<Either<Failure, UserProfileModel>> getUserProfile();
  Future<Either<Failure, bool>> updateUserProfile(
      Map<String,dynamic> userData);
  Future<Either<Failure, OtpResponseModel>> getOtpForOld();
  Future<Either<Failure, String>> verifyOldOtp(Map<String, dynamic> userData);
  Future<Either<Failure, OtpResponseModel>> getOtpForNew(
      Map<String, dynamic> userData);
  Future<Either<Failure, String>> verifyNewOtp(Map<String, dynamic> userData);
  Future<Either<Failure,bool>> deposit(Map<String,dynamic> data);
  Future<Either<Failure,PlatformCommissionModel>> getPlatformCommission();
  Future<Either<Failure,DepositTransactionModel>> getDepositTransaction(String url);

  Future<Either<Failure,bool>> updateUserLanguage(FormData formdata);



}

class UserProfileDataSourceImple implements UserProfileDataSource {
  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile() async {
    try {
      final response = await sl<DioClient>().get(ApiUrl.customer);
      if (response.statusCode == 200) {
        final userProfile =
            await Isolate.run(() => UserProfileModel.fromJson(response.data));
        return Right(userProfile);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserProfile(
      Map<String,dynamic> userData) async {
    FormData formData = FormData.fromMap({
      'first_name': userData['first_name'],
      'last_name': userData["last_name"],
    });

    // Check if image is provided before adding to FormData
    if (userData['image'] != null) {
      MultipartFile multipartFile = await MultipartFile.fromFile(
        userData['image']!.path,
      );
      formData.files.add(MapEntry('profilePicture', multipartFile));
    }
    try {
      final response = await sl<DioClient>().put(ApiUrl.customer, data: formData);
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, OtpResponseModel>> getOtpForOld() async {
    try {
      final response = await sl<DioClient>().get(ApiUrl.changePhone);
      if (response.statusCode == 201) {
        final otpEntity =
            await Isolate.run(() => OtpResponseModel.fromJson(response.data));
        return Right(otpEntity);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOldOtp(
      Map<String, dynamic> userData) async {
    try {
      final response =
          await sl<DioClient>().post(ApiUrl.changePhone, data: userData);
      if (response.statusCode == 201) {
        return Right(response.data['message']);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['error'].toString()));
    }
  }

  @override
  Future<Either<Failure, OtpResponseModel>> getOtpForNew(
      Map<String, dynamic> userData) async {
    try {
      final response =
          await sl<DioClient>().put(ApiUrl.changePhone, data: userData);
      if (response.statusCode == 200) {
        final otpEntity =
            await Isolate.run(() => OtpResponseModel.fromJson(response.data));
        return Right(otpEntity);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> verifyNewOtp(
      Map<String, dynamic> userData) async {
    try {
      final response =
          await sl<DioClient>().patch(ApiUrl.changePhone, data: userData);
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.response!.data['error'].toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deposit(Map<String, dynamic> data)async{
    try {
      final response = await sl<DioClient>().post(ApiUrl.deposit, data: data);
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, PlatformCommissionModel>> getPlatformCommission()async{
    try {
      final response = await sl<DioClient>().get(ApiUrl.commission);
      if (response.statusCode == 200) {
        final commission =
        await Isolate.run(() => PlatformCommissionModel.fromMap(response.data));
        return Right(commission);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }

  }

  @override
  Future<Either<Failure, DepositTransactionModel>> getDepositTransaction(String url)async{
    try {
      final response =url.isNotEmpty?await sl<DioClient>().get(url.substring(ApiUrl.baseUrl.length)): await sl<DioClient>().get(ApiUrl.depositTransaction);
      if (response.statusCode == 200) {
        final depositTransaction =
        await Isolate.run(() => DepositTransactionModel.fromMap(response.data));
        return Right(depositTransaction);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> paymentConfig(Map<String, dynamic> config)async{
    try {
      final response = await sl<DioClient>().post(ApiUrl.paymentConfig,data: config);
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, PaymentConfigModel>> getPaymentConfig()async{
    try {
      final response = await sl<DioClient>().get(ApiUrl.paymentConfig);
      if (response.statusCode == 200) {
        final paymentConfig =
        await Isolate.run(() => PaymentConfigModel.fromMap(response.data));
        return Right(paymentConfig);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserLanguage(FormData formdata)async{
    try {
      final response = await sl<DioClient>().put(ApiUrl.customer, data: formdata);
      if (response.statusCode == 200) {
        return Right(true);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }
}
