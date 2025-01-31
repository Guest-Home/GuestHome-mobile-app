part of 'payment_setting_bloc.dart';

enum PaymentMethod{
  telebirr(name:"Telebirr",code:"TELEBIRR_USSD"),
  mpesaa(name:"Mpesaa",code:"MPESA");

  final String name;
  final String code;

  const PaymentMethod({required this.name, required this.code});

}

class PaymentSettingState extends Equatable {
  const PaymentSettingState({
    this.amount='500',
    this.paymentMethod=PaymentMethod.telebirr,
    this.isAcceptingPayment=true

});

  final String amount;
  final bool isAcceptingPayment;
  final PaymentMethod paymentMethod;

  PaymentSettingState copyWith({
    String? amount,
    bool? isAcceptingPayment,
    PaymentMethod? paymentMethod
}){
    return PaymentSettingState(
      amount: amount??this.amount, isAcceptingPayment: isAcceptingPayment??this.isAcceptingPayment,
      paymentMethod: paymentMethod??this.paymentMethod
    );
  }


  @override
  List<Object?> get props =>[amount,paymentMethod];
}

final class PaymentSettingInitial extends PaymentSettingState {
  @override
  List<Object> get props => [];
}
final class PaymentSettingError extends PaymentSettingState {
  final Failure failure;
  const PaymentSettingError({required this.failure});
  @override
  List<Object> get props => [failure];
}

class DepositPaymentLoading extends PaymentSettingState{
   DepositPaymentLoading(PaymentSettingState currentState):super(
     paymentMethod: currentState.paymentMethod,
     amount: currentState.amount
   );
}
class PlatformCommissionLoading extends PaymentSettingState{}
class PlatformCommissionLoaded extends PaymentSettingState{
  final PlatformCommissionEntity platformCommissionEntity;
  const PlatformCommissionLoaded({required this.platformCommissionEntity});
}
class DepositPaymentSuccess extends PaymentSettingState{
  DepositPaymentSuccess(PaymentSettingState currentState):super(
  paymentMethod: currentState.paymentMethod,
  amount: currentState.amount
  );
}
