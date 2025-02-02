part of 'request_bloc.dart';

abstract class RequestEvent extends Equatable {
  const RequestEvent();

  @override
  List<Object> get props => [];
}

class GetReservationEvent extends RequestEvent{}

class AcceptReservationEvent extends RequestEvent{
  final int id;
  const AcceptReservationEvent({required this.id});
}

class RejectReservationEvent extends RequestEvent{
  final int id;
  const RejectReservationEvent({required this.id});
}
class LoadMoreReservationEvent extends RequestEvent {}