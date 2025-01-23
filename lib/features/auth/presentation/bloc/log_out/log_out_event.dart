part of 'log_out_bloc.dart';


abstract class LogOutEvent {}

class UserLogoutEvent extends LogOutEvent{}
class DeactivateEvent extends LogOutEvent{}
