part of 'search_bloc.dart';

class SearchState extends Equatable {
   const SearchState({this.property=const GpropertyEntity(),
     this.hostProperties=const[]});

   final GpropertyEntity property;
   final List<PropertyEntity> hostProperties;

  SearchState copyWith({
    GpropertyEntity? property,
    List<PropertyEntity>? hostProperties
  }){
    return SearchState(
        property: property??this.property,
        hostProperties: hostProperties??this.hostProperties

    );
  }
  @override
  List<Object> get props => [property,hostProperties];
}
class SearchInitial extends SearchState {}

class SearchLoading extends SearchState{
   SearchLoading(SearchState currentState):super(
      property: currentState.property,
      hostProperties: currentState.hostProperties
  );
}
class SearchGuestLodeState extends SearchState{
   SearchGuestLodeState(SearchState currentState):super(
      property: currentState.property
  );
}
class SearchGuestLoadingMoreState extends SearchState {
  SearchGuestLoadingMoreState(SearchState currentState):super(
      property: currentState.property,
  );
}



// class SearchHostLodeState extends SearchState{
//   SearchHostLodeState(SearchState currentState):super(
//       hostProperties: currentState.hostProperties
//   );
// }
// class SearchHostLoadingMoreState extends SearchState {
//   SearchHostLoadingMoreState(SearchState currentState):super(
//     hostProperties: currentState.hostProperties,
//   );
// }

class SearchErrorState extends SearchState{
  final Failure failure;
   SearchErrorState(SearchState currentState,{required this.failure}):super(
    hostProperties: currentState.hostProperties,
  );
}