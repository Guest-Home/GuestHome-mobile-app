part of 'change_phone_bloc.dart';


abstract class ChangePhoneEvent {}

class GetOtpForOldPhoneEvent extends ChangePhoneEvent{
  final String oldPone;
   GetOtpForOldPhoneEvent({required this.oldPone});
}

class AddOldOtpEvent extends ChangePhoneEvent{
  final String otp;
  AddOldOtpEvent({required this.otp});
}
class AddNewOtpEvent extends ChangePhoneEvent{
  final String otp;
  AddNewOtpEvent({required this.otp});
}
class VerifyOldOtpEvent extends ChangePhoneEvent{}
class VerifyNewOtpEvent extends ChangePhoneEvent{}
class GetOtpForNewPhoneEvent extends ChangePhoneEvent{
  final String newPhone;
  GetOtpForNewPhoneEvent({required this.newPhone});
}