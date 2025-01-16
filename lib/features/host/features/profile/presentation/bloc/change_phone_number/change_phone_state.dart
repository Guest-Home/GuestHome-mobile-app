part of 'change_phone_bloc.dart';


class ChangePhoneState extends Equatable {
  const ChangePhoneState({this.oldPhone='',this.newPhone="",this.oldOtp='', this.newOtp='', });

  final String oldPhone;
  final String newPhone;
  final String oldOtp;
  final String newOtp;

  ChangePhoneState copyWith({
    String? oldPhone,
    String? newPhone,
    String? oldOtp,
    String? newOtp
}){
    return ChangePhoneState(
      newPhone: newPhone??this.newPhone,
      oldPhone: oldPhone??this.oldPhone,
      oldOtp: oldOtp??this.oldOtp,
      newOtp: newOtp??this.newPhone
    );
}

  @override
  List<Object?> get props =>[oldPhone,newPhone,oldOtp,newOtp];
}

final class ChangePhoneInitial extends ChangePhoneState {}

class GettingOtpNewPhone extends ChangePhoneState{
  GettingOtpNewPhone(ChangePhoneState currentState):super(
      oldPhone: currentState.oldPhone,
      newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
      newOtp:  currentState.newOtp
  );
}
class GettingOtpNewPhoneSuccess extends ChangePhoneState{
  final OtpResponseEntity otpResponseEntity;
  GettingOtpNewPhoneSuccess(ChangePhoneState currentState,{required this.otpResponseEntity}):super(
      oldPhone: currentState.oldPhone,
      newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
      newOtp:  currentState.newOtp
  );
}

class GettingOtpOldPhone extends ChangePhoneState{
  GettingOtpOldPhone(ChangePhoneState currentState):super(
      oldPhone: currentState.oldPhone,
      newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
    newOtp:  currentState.newOtp
  );
}
class GettingOtpOldPhoneSuccess extends ChangePhoneState{
  final OtpResponseEntity otpResponseEntity;
  GettingOtpOldPhoneSuccess(ChangePhoneState currentState,{required this.otpResponseEntity}):super(
      oldPhone: currentState.oldPhone,
      newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
      newOtp:  currentState.newOtp
  );
}
class VerifyingOldPhoneNumber extends ChangePhoneState{
  VerifyingOldPhoneNumber(ChangePhoneState currentState):super(
    oldPhone: currentState.oldPhone,
    newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
      newOtp:  currentState.newOtp
  );
}

class PhoneChangeErrorState extends ChangePhoneState{
  final Failure failure;
  PhoneChangeErrorState(ChangePhoneState currentState,{required this.failure}):super(
      oldPhone: currentState.oldPhone,
      newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
      newOtp:  currentState.newOtp
  );
}


class VerifyingOtpOld extends ChangePhoneState{
  VerifyingOtpOld(ChangePhoneState currentState):super(
      oldPhone: currentState.oldPhone,
      newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
      newOtp:  currentState.newOtp
  );
}
class VerifyingOtpOldSuccess extends ChangePhoneState{
  final String message;
  VerifyingOtpOldSuccess(ChangePhoneState currentState,{required this.message}):super(
      oldPhone: currentState.oldPhone,
      newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
      newOtp:  currentState.newOtp
  );
}
class VerifyingOtpNewSuccess extends ChangePhoneState{
  final String message;
  VerifyingOtpNewSuccess(ChangePhoneState currentState,{required this.message}):super(
      oldPhone: currentState.oldPhone,
      newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
      newOtp:  currentState.newOtp
  );
}
class VerifyingOtpNew extends ChangePhoneState{
  VerifyingOtpNew(ChangePhoneState currentState):super(
      oldPhone: currentState.oldPhone,
      newPhone: currentState.newPhone,
      oldOtp: currentState.oldOtp,
      newOtp:  currentState.newOtp
  );
}

