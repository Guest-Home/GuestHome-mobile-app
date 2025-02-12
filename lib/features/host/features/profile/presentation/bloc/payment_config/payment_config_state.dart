part of 'payment_config_bloc.dart';

 class PaymentConfigState extends Equatable {
   const PaymentConfigState({this.isAcceptingPayment=false,this.paymentConfigEntity=const PaymentConfigEntity()});


   final bool isAcceptingPayment;
   final PaymentConfigEntity paymentConfigEntity;

   PaymentConfigState copyWith({
     bool? isAcceptingPayment,
     PaymentConfigEntity? paymentConfigEntity
 }){
     return PaymentConfigState(
       isAcceptingPayment: isAcceptingPayment??this.isAcceptingPayment,
       paymentConfigEntity: paymentConfigEntity??this.paymentConfigEntity
     );
}

  @override
  List<Object?> get props =>[isAcceptingPayment,paymentConfigEntity];
 }

final class PaymentConfigInitial extends PaymentConfigState {}
class PaymentConfigLoadingState extends PaymentConfigState{}
class PaymentConfigUpdatedState extends PaymentConfigState{}
class PaymentConfigFailureState extends PaymentConfigState{
   final Failure failure;
  const PaymentConfigFailureState({required this.failure});
}

