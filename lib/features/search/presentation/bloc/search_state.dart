part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({this.properties=const []});

  final List<PropertyEntity> properties;

  SearchState copyWith({
    List<PropertyEntity>? properties
}){
    return SearchState(
      properties: properties??this.properties
    );
  }


  @override
  List<Object> get props => [properties];
}
class SearchInitial extends SearchState {

}

class SearchLoading extends SearchState{
  SearchLoading(SearchState currentState):super(
    properties: currentState.properties
  );
}
class SearchLodeState extends SearchState{
   SearchLodeState(SearchState currentState,):super(
    properties: currentState.properties
  );
}
class SearchErrorState extends SearchState{
  final Failure failure;
  SearchErrorState(SearchState currentState, {required this.failure}):super(
    properties: currentState.properties
  );
}