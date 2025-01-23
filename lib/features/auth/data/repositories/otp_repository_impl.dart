import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/auth/data/datasources/apiDataSource/api_data_source.dart';
import 'package:minapp/features/auth/data/models/customer_profile_model.dart';
import 'package:minapp/features/auth/data/models/otp_response_model.dart';
import 'package:minapp/features/auth/data/models/verify_otp_model.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';
import 'package:minapp/features/auth/domain/usecases/create_customer_profile_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/create_otp_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:minapp/service_locator.dart';

class OtpRepositoryImpl implements OtpRepository {
  @override
  Future<Either<Failure, OtpResponseModel>> createOtp(
      CreateOtpParams params) async {
    return await sl<ApiDataSource>().createOtp(params);
  }

  @override
  Future<Either<Failure, VerifyOtpModel>> verifyOtp(
      VerifyOtpParams params) async {
    return await sl<ApiDataSource>().verifyOtp(params);
  }

  @override
  Future<Either<Failure, CustomerProfileModel>> createCustomerProfile(
      CreateCustomerParams params) async {
    return await sl<ApiDataSource>().createCustomerProfile(params);
  }

  @override
  Future<Either<Failure, String>> logOut(Map<String, dynamic> data)async{
    return await sl<ApiDataSource>().logOut(data);
  }

  @override
  Future<Either<Failure, String>> deactivateAccount(Map<String, dynamic> data)async{
    return await sl<ApiDataSource>().deactivateAccount(data);
  }
}
