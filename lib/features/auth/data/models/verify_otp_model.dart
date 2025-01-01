import 'package:minapp/features/auth/domain/entities/verify_otp_entity.dart';

class VerifyOtpModel extends VerifyOtpEntity {
  const VerifyOtpModel({required super.refresh, required super.access});

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(refresh: json['refresh'], access: json['access']);
  }
}
