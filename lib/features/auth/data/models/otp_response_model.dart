import 'package:minapp/features/auth/domain/entities/otp_response_entity.dart';

class OtpResponseModel extends OtpResponseEntity {
  const OtpResponseModel({required super.message});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(message: json['message']);
  }
}
