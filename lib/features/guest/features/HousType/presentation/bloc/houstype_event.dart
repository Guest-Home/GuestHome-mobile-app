part of 'houstype_bloc.dart';

abstract class HoustypeEvent extends Equatable {
  const HoustypeEvent();

  @override
  List<Object> get props => [];
}

class GetPropertyByHouseTypeEvent extends HoustypeEvent {
  final String name;
  const GetPropertyByHouseTypeEvent({required this.name});
}
