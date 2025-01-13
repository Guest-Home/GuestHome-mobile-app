part of 'booking_bloc.dart';


enum IdType{Passport,NationalID,KebeleID,DriverLicense}

class BookingState {

  BookingState({
    this.firstName='',
    this.lastName='',
    this.phoneNumber='',
    this.checkOut='',
    this.checkIn='',
    this.countryCode='',
    this.idType=IdType.Passport,
});

  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String countryCode;
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
      lastName: lastName??this.lastName,
      firstName: firstName??this.firstName,
      phoneNumber: phoneNumber??this.phoneNumber,
      countryCode: countryCode??this.countryCode,
      checkIn: checkIn??this.checkIn,
      checkOut: checkOut??this.checkOut,
      idType: idType??this.idType
    );
  }
}

final class BookingInitial extends BookingState {}
class BookingLoadingState extends BookingState{}
class BookingErrorState extends BookingState{
  final Failure failure;
  BookingErrorState({required this.failure});
}
class BookingSuccessState extends BookingState{
  final bool booked;
  BookingSuccessState({required this.booked});
}