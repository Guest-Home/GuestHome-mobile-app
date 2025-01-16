part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}


class GetUserProfileEvent extends ProfileEvent{}
class UpdateUserProfileLoading extends ProfileEvent{}
class UpdateUserProfileEvent extends ProfileEvent{
  final Map<String,dynamic> userData;
  const UpdateUserProfileEvent({required this.userData});
}
