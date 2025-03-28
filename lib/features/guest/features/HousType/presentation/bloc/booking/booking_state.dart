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

final class BookingInitial extends BookingState {
}
final class NoInternetBookingState extends BookingState {
  NoInternetBookingState(BookingState currentState)
      : super(
      checkIn:currentState.checkIn,
      checkOut: currentState.checkOut,
      idType: currentState.idType
  );
}
class BookingLoadingState extends BookingState{
  BookingLoadingState(BookingState currentState)
      : super(
      checkIn:currentState.checkIn,
      checkOut: currentState.checkOut,
      idType: currentState.idType
  );
}
class BookingErrorState extends BookingState{
  final Failure failure;
  BookingErrorState(BookingState currentState,{required this.failure}): super(
checkIn:currentState.checkIn,
checkOut: currentState.checkOut,
idType: currentState.idType
);
}
class BookingSuccessState extends BookingState{
  final bool booked;
  BookingSuccessState(BookingState currentState,{required this.booked})
      : super(
      checkIn:currentState.checkIn,
      checkOut: currentState.checkOut,
      idType: currentState.idType
  );
}