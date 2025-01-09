part of 'total_property_bloc.dart';

sealed class TotalPropertyEvent extends Equatable {
  const TotalPropertyEvent();
}
class GetTotalPropertyEvent extends TotalPropertyEvent{
  @override
  List<Object?> get props =>[];
}