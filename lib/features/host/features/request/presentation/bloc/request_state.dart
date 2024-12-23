part of 'request_bloc.dart';

abstract class RequestState extends Equatable {
  const RequestState();  

  @override
  List<Object> get props => [];
}
class RequestInitial extends RequestState {}
