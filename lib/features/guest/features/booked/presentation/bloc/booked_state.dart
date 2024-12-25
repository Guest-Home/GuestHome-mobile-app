part of 'booked_bloc.dart';

abstract class BookedState extends Equatable {
  const BookedState();  

  @override
  List<Object> get props => [];
}
class BookedInitial extends BookedState {}
