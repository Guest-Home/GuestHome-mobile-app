part of 'houstype_bloc.dart';

class HoustypeState extends Equatable {
    const HoustypeState({this.properties=const GuestPropertyEntity()});

    final GuestPropertyEntity properties;

   HoustypeState copyWith({
     GuestPropertyEntity? properties
}){
     return HoustypeState(
       properties: properties??this.properties
     );
   }

  @override
  List<Object> get props => [properties];
}

class HoustypeInitial extends HoustypeState {}

class HouseTypeLoadingState extends HoustypeState {
  HouseTypeLoadingState(HoustypeState currentState):super(
    properties: currentState.properties
  );
}

class HouseTYpeLoadedState extends HoustypeState {
   HouseTYpeLoadedState(HoustypeState currentState):super(
      properties: currentState.properties
  );
}
class HouseTypeLoadingMoreState extends HoustypeState {
  HouseTypeLoadingMoreState(HoustypeState currentState):super(
      properties: currentState.properties
  );
}
class HouseTYpeErrorState extends HoustypeState {
  final Failure failure;
  HouseTYpeErrorState(HoustypeState currentState,{required this.failure}):super(
    properties: currentState.properties
  );
}
