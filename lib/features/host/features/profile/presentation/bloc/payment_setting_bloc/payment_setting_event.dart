part of 'payment_setting_bloc.dart';

abstract class PaymentSettingEvent extends Equatable {
  const PaymentSettingEvent();
}

class AddPaymentMethodEvent extends PaymentSettingEvent{
  final PaymentMethod paymentMethod;
  const AddPaymentMethodEvent({required this.paymentMethod});

  @override
  List<Object?> get props =>[paymentMethod];
}
class AddAmountEvent extends PaymentSettingEvent{
  final String amount;
  const AddAmountEvent({required this.amount});

  @override
  List<Object?> get props =>[amount];
}
class MakePaymentEvent extends PaymentSettingEvent{
  @override
  List<Object?> get props =>[];
}
class GetPlatformCommissionEvent extends PaymentSettingEvent{
  @override
  List<Object?> get props =>[];
}