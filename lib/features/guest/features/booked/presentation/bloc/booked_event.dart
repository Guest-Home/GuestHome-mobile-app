part of 'booked_bloc.dart';

abstract class BookedEvent extends Equatable {
  const BookedEvent();

  @override
  List<Object> get props => [];
}

class GetMyBookingEvent extends BookedEvent{}
class BookedResetEvent extends BookedEvent{}

class CancelBookingEvent extends BookedEvent{
  final int id;
  const CancelBookingEvent({required this.id});
}
