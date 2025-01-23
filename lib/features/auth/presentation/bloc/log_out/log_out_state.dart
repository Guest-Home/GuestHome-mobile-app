part of 'log_out_bloc.dart';

abstract class LogOutState {}

final class LogOutInitial extends LogOutState {}

class LogOutLoadingState extends LogOutState{}
class LogOutLoadedState extends LogOutState{}
class LogOutErrorState extends LogOutState{
  final Failure failure;
  LogOutErrorState({required this.failure});
}

// deactivate account state
class DeactivateLoadingState extends LogOutState{}
class DeactivatedState extends LogOutState{}
