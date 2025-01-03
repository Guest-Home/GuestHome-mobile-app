
import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:minapp/features/host/features/profile/data/models/user_profile_model.dart';

import '../../../../../../core/apiConstants/api_url.dart';
import '../../../../../../core/error/failure.dart';
import '../../../../../../core/network/dio_client.dart';
import '../../../../../../service_locator.dart';

abstract class UserProfileDataSource{
  Future<Either<Failure,UserProfileModel>> getUserProfile();
}

class UserProfileDataSourceImple implements UserProfileDataSource{
  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile()async{
    try {
      final response = await sl<DioClient>().get(ApiUrl.customer);
      if (response.statusCode == 200) {
        final userProfile=await Isolate.run(() =>UserProfileModel.fromJson(response.data));
        return Right(userProfile);
      } else {
        return Left(ServerFailure(response.data['error']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message.toString()));
    }
  }

}