part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}


class GetUserProfileEvent extends ProfileEvent{}
class ResetProfileEvent extends ProfileEvent{}

