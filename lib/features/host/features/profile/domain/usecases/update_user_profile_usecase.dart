
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minapp/core/useCases/use_case.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../service_locator.dart';
import '../repositories/user_profile_repository.dart';

class UpdateUserProfileUseCase extends UseCase<Either<Failure,bool>,Map<String,dynamic>>{
  @override
  Future<Either<Failure, bool>> call(Map<String,dynamic> param)async{
    return await sl<UserProfileRepository>().updateUserProfile(param);
  }

}

class UpdateCustomerParams extends Equatable {
  final String firstName;
  final String lastName;
  final XFile? image;
  const UpdateCustomerParams(
      {required this.firstName,
        required this.lastName,
        required this.image});

  @override
  List<Object> get props => [firstName, lastName, image!];
}