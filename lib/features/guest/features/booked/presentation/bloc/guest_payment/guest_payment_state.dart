part of 'guest_payment_bloc.dart';


class GuestPaymentState extends Equatable {
  const GuestPaymentState({this.paymentMethod=PaymentMethod.telebirr});
  final PaymentMethod paymentMethod;

  GuestPaymentState copyWith({
    PaymentMethod? paymentMethod,
  }){
    return GuestPaymentState(
        paymentMethod: paymentMethod??this.paymentMethod,
    );
  }
  @override
  List<Object?> get props =>[paymentMethod];
}

final class GuestPaymentInitial extends GuestPaymentState {}
final class NoInternetGuestPayment extends GuestPaymentState {}
final class GuestReservationPaymentLoading extends GuestPaymentState {}
final class GuestReservationPaymentSuccess extends GuestPaymentState {}
final class GuestPaymentError extends GuestPaymentState {
  final Failure failure;
  const GuestPaymentError({required this.failure});
  @override
  List<Object> get props => [failure];
}