import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minapp/core/useCases/use_case.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';
import 'package:minapp/service_locator.dart';

import '../../../../core/error/failure.dart';
import '../entities/customer_profile_entity.dart';

class CreateCustomerProfileUsecase extends UseCase<
    Either<Failure, CustomerProfileEntity>, CreateCustomerParams> {
  @override
  Future<Either<Failure, CustomerProfileEntity>> call(
      CreateCustomerParams param) async {
    return await sl<OtpRepository>().createCustomerProfile(param);
  }
}

class CreateCustomerParams extends Equatable {
  final String firstName;
  final String lastName;
  final String gender;
  final XFile image;
  final String typeOfCustomer;
  const CreateCustomerParams(
      {required this.firstName,
      required this.lastName,
      required this.gender,
        required this.typeOfCustomer,
      required this.image});

  @override
  List<Object> get props => [firstName, lastName, gender, image,typeOfCustomer];
}
