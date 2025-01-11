part of 'houstype_bloc.dart';

abstract class HoustypeState extends Equatable {
  const HoustypeState();

  @override
  List<Object> get props => [];
}

class HoustypeInitial extends HoustypeState {}

class HouseTypeLoadingState extends HoustypeState {}

class HouseTYpeLoadedState extends HoustypeState {
  final GpropertyEntity properties;
  const HouseTYpeLoadedState({required this.properties});
}
class HouseTYpeErrorState extends HoustypeState {
  final Failure failure;
  const HouseTYpeErrorState({required this.failure});
}
