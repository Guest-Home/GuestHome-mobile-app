part of 'booking_bloc.dart';


abstract class BookingEvent {}

class AddFirstNameEvent extends BookingEvent{
  final String fName;
  AddFirstNameEvent({required this.fName});
}
class AddLastNameEvent extends BookingEvent{
  final String lName;
  AddLastNameEvent({required this.lName});
}

class AddPhoneEvent extends BookingEvent{
  final String phone;
  AddPhoneEvent({required this.phone});
}
class AddCountryCodeEvent extends BookingEvent{
  final String code;
  AddCountryCodeEvent({required this.code});
}
class AddCheckInEvent extends BookingEvent{
  final String checkIn;
  AddCheckInEvent({required this.checkIn});
}
class AddCheckOutEvent extends BookingEvent{
  final String checkOut;
  AddCheckOutEvent({required this.checkOut});
}
class AddIdEvent extends BookingEvent{
  final IdType id;
  AddIdEvent({required this.id});
}

class BookEvent extends BookingEvent{}