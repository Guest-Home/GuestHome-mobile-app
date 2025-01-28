import 'dart:isolate';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/core/error/error_response.dart';
import 'package:minapp/features/auth/data/models/customer_profile_model.dart';
import 'package:minapp/features/auth/data/models/otp_response_model.dart';
import 'package:minapp/features/auth/domain/usecases/create_customer_profile_usecase.dart';
import 'package:minapp/service_locator.dart';
import '../../../../../core/apiConstants/api_url.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../domain/usecases/create_otp_usecase.dart';
import '../../../domain/usecases/verify_otp_usecase.dart';
import '../../models/verify_otp_model.dart';

abstract class ApiDataSource {
  Future<Either<Failure, OtpResponseModel>> createOtp(CreateOtpParams params);
  Future<Either<Failure, VerifyOtpModel>> verifyOtp(VerifyOtpParams params);
  Future<Either<Failure, CustomerProfileModel>> createCustomerProfile(
      CreateCustomerParams params);
  Future<Either<Failure, String>> logOut(Map<String, dynamic> data);
  Future<Either<Failure, String>> deactivateAccount(Map<String, dynamic> data);
  Future<Either<Failure, OtpResponseModel>> createTgOtp(
      Map<String, dynamic> data);
  Future<Either<Failure, VerifyOtpModel>> verifyTgOtp(
      Map<String, dynamic> data);
}

class ApiDataSourceImpl implements ApiDataSource {
  @override
  Future<Either<Failure, OtpResponseModel>> createOtp(
      CreateOtpParams params) async {
    try {
      Map<String, dynamic> otpData = {"phone_number": params.phoneNumber};
      final response = await sl<DioClient>().post(ApiUrl.otp, data: otpData);
      if (response.statusCode == 201) {
        final createdOtP =
            await Isolate.run(() => OtpResponseModel.fromJson(response.data));
        return Right(createdOtP);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      // return Left(ServerFailure(e.response!.data["Error"].toString()));
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpModel>> verifyOtp(
      VerifyOtpParams params) async {
    try {
      Map<String, dynamic> otpData = {
        "phone_number": params.phoneNumber,
        "otp": params.otp,
        "device_id": params.deviceId
      };

      final response = await sl<DioClient>().put(ApiUrl.otp, data: otpData);
      if (response.statusCode == 200) {
        final verify =
            await Isolate.run(() => VerifyOtpModel.fromJson(response.data));
        return Right(verify);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, CustomerProfileModel>> createCustomerProfile(
      CreateCustomerParams params) async {
    MultipartFile multipartFile = await MultipartFile.fromFile(
      params.image.path,
    );

    // Create a FormData object
    final formData = FormData.fromMap({
      'profilePicture': multipartFile,
      'language': 'en',
      'gender': params.gender,
      'first_name': params.firstName,
      'last_name': params.lastName,
      'typeOfCustomer': params.typeOfCustomer
    });

    try {
      final response = await sl<DioClient>().post(
        ApiUrl.customer,
        data: formData,
      );
      if (response.statusCode == 201) {
        final customerProfile = await Isolate.run(
            () => CustomerProfileModel.fromJson(response.data));
        return Right(customerProfile);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      // return Left(ServerFailure(e.response!.data.toString()));
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> logOut(Map<String, dynamic> data) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.logOut,
        data: data,
      );
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      // return Left(ServerFailure(e.response!.data.toString()));
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> deactivateAccount(
      Map<String, dynamic> data) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.deactivateAccount,
        data: data,
      );
      if (response.statusCode == 200) {
        return Right(response.data['message']);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      // return Left(ServerFailure(e.response!.data.toString()));
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, OtpResponseModel>> createTgOtp(
      Map<String, dynamic> data) async {
    try {
      final response = await sl<DioClient>().post(ApiUrl.tGOtp, data: data);
      if (response.statusCode == 200) {
        final createdOtP =
            await Isolate.run(() => OtpResponseModel.fromJson(response.data));
        return Right(createdOtP);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpModel>> verifyTgOtp(
      Map<String, dynamic> data) async {
    try {
      final response = await sl<DioClient>().put(ApiUrl.tGOtp, data: data);
      if (response.statusCode == 200) {
        final verify =
            await Isolate.run(() => VerifyOtpModel.fromJson(response.data));
        return Right(verify);
      } else {
        return Left(ServerFailure(response.data['Error']));
      }
    } on DioException catch (e) {
      return Left(ErrorResponse().mapDioExceptionToFailure(e));
    }
  }
}
