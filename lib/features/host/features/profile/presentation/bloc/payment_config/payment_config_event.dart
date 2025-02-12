part of 'payment_config_bloc.dart';


abstract class PaymentConfigEvent {}
class AcceptPaymentEvent extends PaymentConfigEvent{
  final bool isAccepting;
  AcceptPaymentEvent({required this.isAccepting});
}
class GetPaymentConfigEvent extends PaymentConfigEvent{}
