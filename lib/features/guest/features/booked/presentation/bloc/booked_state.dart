part of 'booked_bloc.dart';

 class BookedState extends Equatable {
   const BookedState({this.booking=const MyBookingEntity() });
  final MyBookingEntity booking;

  BookedState copyWith({
    MyBookingEntity? booking
 }){
    return BookedState(
      booking: booking??this.booking
    );
  }

  @override
  List<Object> get props => [booking];
}
class BookedInitial extends BookedState {}

class MyBookingLoadingState extends BookedState{
   MyBookingLoadingState(BookedState currentState):super(
     booking: currentState.booking
   );
}
class MyBookingLoadedState extends BookedState{
   MyBookingLoadedState(BookedState currentState):super(
      booking: currentState.booking
  );
}
class MyBookingErrorState extends BookedState{
  final Failure failure;
   MyBookingErrorState(BookedState currentState,{required this.failure}):super(
  booking: currentState.booking
  );
}
class CancelBookingLoadingState extends BookedState{}
class CancelBookingSuccessState extends BookedState{}

class CancelBookingErrorState extends BookedState{
  final Failure failure;
  const CancelBookingErrorState({required this.failure});
}