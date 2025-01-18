part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}
class SearchPropertyEvent extends SearchEvent{
  final String name;
  const SearchPropertyEvent({required this.name});
}
class HostSearchPropertyEvent extends SearchEvent{
  final String name;
  const HostSearchPropertyEvent({required this.name});
}