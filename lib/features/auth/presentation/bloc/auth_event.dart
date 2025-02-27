part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AddPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;
  const AddPhoneNumberEvent({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}

class CountryCodeSelectorEvent extends AuthEvent {
  final String countryCode;

  const CountryCodeSelectorEvent({required this.countryCode});

  @override
  List<Object> get props => [countryCode];
}

class CreateOtpEvent extends AuthEvent {
  final String phone;

  const CreateOtpEvent({required this.phone});
  @override
  List<Object> get props => [phone];
}

class CreateTgOtpEvent extends AuthEvent {
  const CreateTgOtpEvent();
  @override
  List<Object> get props => [];
}

class AddOtpCodeEvent extends AuthEvent {
  final String otpCode;
  const AddOtpCodeEvent({required this.otpCode});
  @override
  List<Object> get props => [otpCode];
}

class AddTgUserNameEvent extends AuthEvent {
  final String tgUserName;
  const AddTgUserNameEvent({required this.tgUserName});
  @override
  List<Object> get props => [tgUserName];
}

class VerifyOtpEvent extends AuthEvent {}

class VerifyTgOtpEvent extends AuthEvent {}

class AddFullNameEvent extends AuthEvent {
  final String fullName;
  const AddFullNameEvent({required this.fullName});

  @override
  List<Object> get props => [fullName];
}

class AddEmailEvent extends AuthEvent {
  final String email;
  const AddEmailEvent({required this.email});
  @override
  List<Object> get props => [email];
}

class AddGenderEvent extends AuthEvent {
  final Gender gender;
  const AddGenderEvent({required this.gender});
  @override
  List<Object> get props => [gender];
}

class SelectPictureEvent extends AuthEvent {}
class AuthResetEvent extends AuthEvent {}

class RemovePictureEvent extends AuthEvent {}

class CreateCustomerProfileEvent extends AuthEvent {}
