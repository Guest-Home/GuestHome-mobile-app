part of 'booking_bloc.dart';


abstract class BookingEvent {}

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

class BookEvent extends BookingEvent{
  final int id;
  BookEvent({required this.id});
}

class ResetBookingEvent extends BookingEvent{

}