part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState();


  @override
  List<Object> get props => [];
}
class SearchInitial extends SearchState {

}

class SearchLoading extends SearchState{
  const SearchLoading();
}
class SearchHostLodeState extends SearchState{
  final List<PropertyEntity>? properties;
  const SearchHostLodeState({required this.properties});
}
class SearchGuestLodeState extends SearchState{
  final GpropertyEntity property;
  const SearchGuestLodeState({required this.property});
}
class SearchErrorState extends SearchState{
  final Failure failure;
  const SearchErrorState({required this.failure});
}