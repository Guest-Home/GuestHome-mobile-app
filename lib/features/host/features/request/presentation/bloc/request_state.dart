part of 'request_bloc.dart';

class RequestState extends Equatable {
  const RequestState({this.reservation=const ReservationModel()});

  final ReservationModel reservation;
  RequestState copyWith({
    ReservationModel? reservation
  }){
    return RequestState(
        reservation: reservation??this.reservation
    );
  }

  @override
  List<Object> get props => [reservation];
}
class RequestInitial extends RequestState {}

class ReservationLoadingState extends RequestState{
  ReservationLoadingState(RequestState currentState):super(
    reservation: currentState.reservation
  );
}

class ReservationLoadedState extends RequestState{
   ReservationLoadedState(RequestState currentState):super(
       reservation: currentState.reservation
   );
}

class ReservationErrorState extends RequestState{
  final Failure failure;
  ReservationErrorState(RequestState currentState,{required this.failure,}):super(
  reservation: currentState.reservation
  );
}


class AcceptingReservationState extends RequestState{
  AcceptingReservationState(RequestState currentState):super(
      reservation: currentState.reservation
  );
}

class AcceptedReservationState extends RequestState{
  final bool isAccepted;
  AcceptedReservationState(RequestState currentState,{required this.isAccepted}):super(
  reservation: currentState.reservation
  );
}
class RejectingReservationState extends RequestState{
  RejectingReservationState(RequestState currentState):super(
      reservation: currentState.reservation
  );
}
class RejectedReservationState extends RequestState{
  final bool isRejected;
  RejectedReservationState(RequestState currentState,{required this.isRejected}):super(
reservation: currentState.reservation
);
}

class ReservationLoadingMoreState extends RequestState {
  ReservationLoadingMoreState(RequestState currentState):super(
      reservation: currentState.reservation
  );
}