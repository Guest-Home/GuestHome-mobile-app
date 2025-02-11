part of 'payment_config_bloc.dart';

 class PaymentConfigState extends Equatable {
   const PaymentConfigState({required this.isAcceptingPayment});


   final bool isAcceptingPayment;

   PaymentConfigState copyWith({
     bool? isAcceptingPayment
 }){
     return PaymentConfigState(
       isAcceptingPayment: isAcceptingPayment??this.isAcceptingPayment
     );
}

  @override
  List<Object?> get props =>[isAcceptingPayment];
 }

final class PaymentConfigInitial extends PaymentConfigState {
  const PaymentConfigInitial({required super.isAcceptingPayment});
}

