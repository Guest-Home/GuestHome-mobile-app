part of 'booked_detail_bloc.dart';

abstract class BookedDetailState {}

final class BookedDetailInitial extends BookedDetailState {}

class BookedDetailLoading extends BookedDetailState{}
class BookedDetailLoaded extends BookedDetailState{
  final BookedDetailEntity booked;
  BookedDetailLoaded({required this.booked});
}

class BookedDetailError extends BookedDetailState{
  final Failure failure;
  BookedDetailError({required this.failure});
}
class NoInternetBookedDetailSate extends BookedDetailState {}
