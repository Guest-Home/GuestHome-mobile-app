part of 'auth_bloc.dart';

enum Gender {
  male(name: "Male", assetPath: "assets/icons/man.png"),
  female(name: "Female", assetPath: "assets/icons/woman.png");

  final String name;
  final String assetPath;

  const Gender({required this.name, required this.assetPath});
}

class AuthState extends Equatable {
  final String countryCode;
  final String phoneNumber;
  final String otpText;
  final String fullName;
  final Gender gender;
  final XFile? profilePhoto;

  const AuthState(
      {this.countryCode = '',
      this.phoneNumber = '',
      this.otpText = '',
      this.fullName = '',
      this.gender = Gender.male,
      this.profilePhoto});

  // CopyWith method to update properties
  AuthState copyWith(
      {String? countryCode,
      String? phoneNumber,
      String? otpText,
      String? fullName,
      Gender? gender,
      XFile? profilePhoto}) {
    return AuthState(
        countryCode: countryCode ?? this.countryCode,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        otpText: otpText ?? this.otpText,
        fullName: fullName ?? this.fullName,
        gender: gender ?? this.gender,
        profilePhoto: profilePhoto ?? this.profilePhoto);
  }

  @override
  List<Object> get props => [
        countryCode,
        phoneNumber,
        otpText,
        fullName,
        gender,
        profilePhoto ?? XFile('')
      ];
}

class CreatingOtpLoadingState extends AuthState {
  CreatingOtpLoadingState(AuthState currentState)
      : super(
            countryCode: currentState.countryCode,
            phoneNumber: currentState.phoneNumber,
            otpText: currentState.otpText,
            fullName: currentState.fullName,
            gender: currentState.gender,
            profilePhoto: currentState.profilePhoto);
}

class OtpCreatedLodedState extends AuthState {
  final OtpResponseEntity otpResponseEntity;
  OtpCreatedLodedState(AuthState currentState, this.otpResponseEntity)
      : super(
            countryCode: currentState.countryCode,
            phoneNumber: currentState.phoneNumber,
            otpText: currentState.otpText,
            fullName: currentState.fullName,
            gender: currentState.gender,
            profilePhoto: currentState.profilePhoto);

  @override
  List<Object> get props => super.props + [otpResponseEntity];
}

class OtpErrorState extends AuthState {
  final Failure failure;
  OtpErrorState(AuthState currentState, this.failure)
      : super(
            countryCode: currentState.countryCode,
            phoneNumber: currentState.phoneNumber,
            otpText: currentState.otpText,
            fullName: currentState.fullName,
            gender: currentState.gender,
            profilePhoto: currentState.profilePhoto);

  @override
  List<Object> get props => super.props + [failure];
}

class VerifyingOtpLoadingState extends AuthState {
  VerifyingOtpLoadingState(AuthState currentState)
      : super(
            countryCode: currentState.countryCode,
            phoneNumber: currentState.phoneNumber,
            otpText: currentState.otpText,
            fullName: currentState.fullName,
            gender: currentState.gender,
            profilePhoto: currentState.profilePhoto);
}

class VerifyedOtpLodedState extends AuthState {
  final VerifyOtpEntity verifyOtpEntity;
  VerifyedOtpLodedState(AuthState currentState, this.verifyOtpEntity)
      : super(
            countryCode: currentState.countryCode,
            phoneNumber: currentState.phoneNumber,
            otpText: currentState.otpText,
            fullName: currentState.fullName,
            gender: currentState.gender,
            profilePhoto: currentState.profilePhoto);

  @override
  List<Object> get props => super.props + [verifyOtpEntity];
}

class ImagePickerError extends AuthState {
  final String error;
  ImagePickerError(AuthState currentState, this.error)
      : super(
            countryCode: currentState.countryCode,
            phoneNumber: currentState.phoneNumber,
            otpText: currentState.otpText,
            fullName: currentState.fullName,
            gender: currentState.gender,
            profilePhoto: currentState.profilePhoto);

  @override
  List<Object> get props => super.props + [error];
}

class CreatingCustomerProfileLoadingState extends AuthState {
  CreatingCustomerProfileLoadingState(AuthState currentState)
      : super(
            countryCode: currentState.countryCode,
            phoneNumber: currentState.phoneNumber,
            otpText: currentState.otpText,
            fullName: currentState.fullName,
            gender: currentState.gender,
            profilePhoto: currentState.profilePhoto);
}

class CreatedCustomerProfileLodedState extends AuthState {
  final CustomerProfileEntity customerProfileEntity;
  CreatedCustomerProfileLodedState(
      AuthState currentState, this.customerProfileEntity)
      : super(
            countryCode: currentState.countryCode,
            phoneNumber: currentState.phoneNumber,
            otpText: currentState.otpText,
            fullName: currentState.fullName,
            gender: currentState.gender,
            profilePhoto: currentState.profilePhoto);

  @override
  List<Object> get props => super.props + [customerProfileEntity];
}
