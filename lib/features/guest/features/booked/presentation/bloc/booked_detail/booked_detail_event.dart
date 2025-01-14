part of 'booked_detail_bloc.dart';

abstract class BookedDetailEvent {}
class GetBookedDetail extends BookedDetailEvent{
  final int id;
  GetBookedDetail({required this.id});
}