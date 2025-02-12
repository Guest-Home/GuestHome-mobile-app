part of 'popular_property_bloc.dart';

class PopularPropertyState extends Equatable {
  const PopularPropertyState({this.properties=const GpropertyEntity()});
  final GpropertyEntity properties;

  PopularPropertyState copyWith({
    GpropertyEntity? properties
}){
    return PopularPropertyState(
      properties: properties??this.properties
    );
  }

  @override
  List<Object?> get props =>[properties];
}

final class PopularPropertyInitial extends PopularPropertyState {}
final class NoInternetPopularProperty extends PopularPropertyState {}

class PopularPropertyLoadingState extends PopularPropertyState{
  PopularPropertyLoadingState(PopularPropertyState currentState):super(
    properties: currentState.properties
  );
}
class PopularPropertyLoadedState extends PopularPropertyState{
  PopularPropertyLoadedState(PopularPropertyState currentState):super(
        properties: currentState.properties
    );
}
class PopularPropertyLoadingMoreState extends PopularPropertyState {
  PopularPropertyLoadingMoreState(PopularPropertyState currentState):super(
      properties: currentState.properties
  );
}

class PopularPropertyErrorState extends PopularPropertyState{
  final Failure failure;
  PopularPropertyErrorState(PopularPropertyState currentState,{required this.failure}):super(
  properties: currentState.properties
  );
}