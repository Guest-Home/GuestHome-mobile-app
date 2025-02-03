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
    this.amount='0',
    this.paymentMethod=PaymentMethod.telebirr,
    this.isAcceptingPayment=false,
    this.platformCommissionEntity=const PlatformCommissionEntity()


});

  final String amount;
  final bool isAcceptingPayment;
  final PaymentMethod paymentMethod;
  final PlatformCommissionEntity platformCommissionEntity;


  PaymentSettingState copyWith({
    String? amount,
    bool? isAcceptingPayment,
    PaymentMethod? paymentMethod,
    PlatformCommissionEntity? platformCommissionEntity
}){
    return PaymentSettingState(
      amount: amount??this.amount,
        isAcceptingPayment: isAcceptingPayment??this.isAcceptingPayment,
      paymentMethod: paymentMethod??this.paymentMethod,
      platformCommissionEntity: platformCommissionEntity??this.platformCommissionEntity
    );
  }


  @override
  List<Object?> get props =>[amount,paymentMethod,isAcceptingPayment,platformCommissionEntity];
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
     amount: currentState.amount,
     platformCommissionEntity: currentState.platformCommissionEntity
   );
}
class PlatformCommissionLoading extends PaymentSettingState{}
class PlatformCommissionLoaded extends PaymentSettingState{
   PlatformCommissionLoaded(PaymentSettingState currentState):super(
      paymentMethod: currentState.paymentMethod,
      amount: currentState.amount,
     platformCommissionEntity: currentState.platformCommissionEntity
  );
}
class DepositPaymentSuccess extends PaymentSettingState{
  DepositPaymentSuccess(PaymentSettingState currentState):super(
  paymentMethod: currentState.paymentMethod,
  amount: currentState.amount,
    platformCommissionEntity: currentState.platformCommissionEntity
  );
}
