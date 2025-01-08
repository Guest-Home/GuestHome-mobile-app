

import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/host/features/profile/domain/entities/user_profile_entity.dart';

abstract class UserProfileRepository{
  Future<Either<Failure,UserProfileEntity>> getUserProfile();
  Future<Either<Failure,bool>> updateUserProfile(Map<String,dynamic> userData);

}