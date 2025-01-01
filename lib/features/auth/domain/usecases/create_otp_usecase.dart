import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/auth/domain/entities/otp_response_entity.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';
import 'package:minapp/service_locator.dart';
import '../../../../core/useCases/use_case.dart';

class CreateOtpUsecase
    extends UseCase<Either<Failure, OtpResponseEntity>, CreateOtpParams> {
  @override
  Future<Either<Failure, OtpResponseEntity>> call(CreateOtpParams param) async {
    return sl<OtpRepository>().createOtp(param);
  }
}

class CreateOtpParams extends Equatable {
  final String phoneNumber;
  const CreateOtpParams({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}
