part of 'request_bloc.dart';

abstract class RequestState extends Equatable {
  @override
  List<Object> get props => [];
}
class RequestInitial extends RequestState {}

class ReservationLoadingState extends RequestState{}

class ReservationLoadedState extends RequestState{
  final ReservationModel reservation;
   ReservationLoadedState({required this.reservation});

}

class ReservationErrorState extends RequestState{
  final Failure failure;
  ReservationErrorState({required this.failure,});
}


class AcceptingReservationState extends RequestState{}
class AcceptedReservationState extends RequestState{
  final bool isAccepted;
  AcceptedReservationState({required this.isAccepted});
}
class RejectingReservationState extends RequestState{}
class RejectedReservationState extends RequestState{
  final bool isRejected;
  RejectedReservationState({required this.isRejected});
}