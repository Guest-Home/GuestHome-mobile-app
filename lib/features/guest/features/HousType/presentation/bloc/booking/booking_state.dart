part of 'booking_bloc.dart';


enum IdType{Passport,NationalID,KebeleID,DriverLicense}

class BookingState {

  BookingState({
    this.checkOut='',
    this.checkIn='',
    this.idType=IdType.Passport,
});

  final String checkIn;
  final String checkOut;
  final IdType idType;

  BookingState copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? countryCode,
    String? checkIn,
    String? checkOut,
    IdType? idType,
}){
    return BookingState(
      checkIn: checkIn??this.checkIn,
      checkOut: checkOut??this.checkOut,
      idType: idType??this.idType
    );
  }
}

final class BookingInitial extends BookingState {}
final class NoInternetBookingState extends BookingState {}
class BookingLoadingState extends BookingState{}
class BookingErrorState extends BookingState{
  final Failure failure;
  BookingErrorState({required this.failure});
}
class BookingSuccessState extends BookingState{
  final bool booked;
  BookingSuccessState({required this.booked});
}