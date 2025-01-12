part of 'popular_property_bloc.dart';

abstract class PopularPropertyState {}

final class PopularPropertyInitial extends PopularPropertyState {}

class PopularPropertyLoadingState extends PopularPropertyState{}
class PopularPropertyLoadedState extends PopularPropertyState{
  final GpropertyEntity properties;
    PopularPropertyLoadedState({required this.properties});
}

class PopularPropertyErrorState extends PopularPropertyState{
  final Failure failure;
  PopularPropertyErrorState({required this.failure});
}