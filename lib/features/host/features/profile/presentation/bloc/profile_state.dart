part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();  

  @override
  List<Object> get props => [];
}
class ProfileInitial extends ProfileState {}

class UserProfileLoadingState extends ProfileState{}
class UserProfileLoadedState extends ProfileState{
  final UserProfileEntity userProfileEntity;
  final String token;
  const UserProfileLoadedState(this.userProfileEntity, this.token);

}

class ProfileErrorState extends ProfileState{
  final Failure failure;

  const ProfileErrorState(this.failure);

}