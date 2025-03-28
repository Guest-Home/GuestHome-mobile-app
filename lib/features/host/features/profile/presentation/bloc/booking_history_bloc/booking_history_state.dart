part of 'booking_history_bloc.dart';

 class BookingHistoryState extends Equatable {
  const BookingHistoryState({this.booking=const MyBookingEntity() });
  final MyBookingEntity booking;

  BookingHistoryState copyWith({
    MyBookingEntity? booking
  }){
    return BookingHistoryState(
        booking: booking??this.booking
    );
  }

  @override
  List<Object> get props => [booking];
}
final class BookingHistoryInitial extends BookingHistoryState {}

class NoInternetSate extends BookingHistoryState {}

class BookingHistoryLoadingState extends BookingHistoryState{
  BookingHistoryLoadingState(BookingHistoryState currentState):super(
      booking: currentState.booking
  );
}
class BookingHistoryLoadingMoreState extends BookingHistoryState{
  BookingHistoryLoadingMoreState(BookingHistoryState currentState):super(
      booking: currentState.booking
  );
}
class BookingHistoryLoadedState extends BookingHistoryState{
  BookingHistoryLoadedState(BookingHistoryState currentState):super(
      booking: currentState.booking
  );
}

final class BookingHistoryError extends BookingHistoryState {
  final Failure failure;
  BookingHistoryError(BookingHistoryState currentState,{required this.failure}):super(
      booking: currentState.booking
  );

}
