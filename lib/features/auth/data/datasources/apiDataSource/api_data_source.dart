import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
}

class ApiDataSourceImpl implements ApiDataSource {
  @override
  Future<Either<Failure, OtpResponseModel>> createOtp(
      CreateOtpParams params) async {
    try {
      Map<String, dynamic> otpData = {"phone_number": params.phoneNumber};
      final response = await sl<DioClient>().post(ApiUrl.otp, data: otpData);
      if (response.statusCode == 201) {
        return Right(OtpResponseModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpModel>> verifyOtp(
      VerifyOtpParams params) async {
    try {
      Map<String, dynamic> otpData = {
        "phone_number": params.phoneNumber,
        "otp": params.otp
      };
      final response = await sl<DioClient>().put(ApiUrl.otp, data: otpData);
      if (response.statusCode == 200) {
        return Right(VerifyOtpModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomerProfileModel>> createCustomerProfile(
      CreateCustomerParams params) async {
    Map<String, String> jsonString = {
      'first_name': params.firstName,
      'last_name': params.lastName,
    };
    File image = File(params.image.path);

    // Create a FormData object
    final formData = FormData.fromMap({
      if (image.path.isNotEmpty)
        'profilePicture': await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      'language': 'en',
      'gender': params.gender,
      'first_name': params.firstName,
      'last_name': params.lastName,
    });

    try {
      final response = await sl<DioClient>().post(
        ApiUrl.customer,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201) {
        print(response.data);
        return Right(CustomerProfileModel.fromJson(response.data));
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      print("//////dio");
      print(e);
      return Left(ServerFailure(e.message.toString()));
    }
  }
}
