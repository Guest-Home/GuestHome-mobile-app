part of 'search_property_bloc.dart';

abstract class SearchPropertyEvent {}

class SearchEvent extends SearchPropertyEvent{
  final String name;
  SearchEvent({required this.name});
}

class ResetEvent extends SearchPropertyEvent{}