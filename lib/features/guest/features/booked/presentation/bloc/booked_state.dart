part of 'booked_bloc.dart';

abstract class BookedState extends Equatable {
  const BookedState();  

  @override
  List<Object> get props => [];
}
class BookedInitial extends BookedState {}

class MyBookingLoadingState extends BookedState{}
class MyBookingLoadedState extends BookedState{
  final MyBookingEntity booking;
  const MyBookingLoadedState({required this.booking});
}
class MyBookingErrorState extends BookedState{
  final Failure failure;
  const MyBookingErrorState({required this.failure});
}
class CancelBookingLoadingState extends BookedState{}
class CancelBookingSuccessState extends BookedState{}

class CancelBookingErrorState extends BookedState{
  final Failure failure;
  const CancelBookingErrorState({required this.failure});
}