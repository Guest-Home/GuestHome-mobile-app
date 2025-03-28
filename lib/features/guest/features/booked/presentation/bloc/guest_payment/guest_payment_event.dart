part of 'guest_payment_bloc.dart';

abstract class GuestPaymentEvent extends Equatable {
  const GuestPaymentEvent();
}
class AddGuestPaymentMethodEvent extends GuestPaymentEvent{
  final PaymentMethod paymentMethod;
  const AddGuestPaymentMethodEvent({required this.paymentMethod});

  @override
  List<Object?> get props =>[paymentMethod];
}
class MakeReservationPaymentEvent extends GuestPaymentEvent{
  final String phone;
  final int id;
  const MakeReservationPaymentEvent({required this.phone,required this.id});

  @override
  List<Object?> get props =>[phone,id];
}
class MakeReservationRestEvent extends GuestPaymentEvent{
  const MakeReservationRestEvent();

  @override
  List<Object?> get props =>[];
}