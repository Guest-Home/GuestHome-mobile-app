part of 'search_property_bloc.dart';

abstract class SearchPropertyState {}

final class SearchPropertyInitial extends SearchPropertyState {}

class SearchPropertyLoading extends SearchPropertyState{}
class SearchPropertyLoaded extends SearchPropertyState{
  final List<PropertyEntity> properties;
  SearchPropertyLoaded({required this.properties});
}

class SearchPropertyError extends SearchPropertyState{
  final Failure failure;
  SearchPropertyError({required this.failure});
}