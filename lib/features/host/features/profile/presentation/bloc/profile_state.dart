part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({this.userProfileEntity=const UserProfileEntity(), this.token=''});

  final UserProfileEntity userProfileEntity;
  final String token;

  ProfileState copyWith({
    UserProfileEntity? userProfileEntity,
    String? token
 }){
    return ProfileState(
       userProfileEntity:userProfileEntity??this.userProfileEntity,
      token:token??this.token
    );
}
  @override
  List<Object> get props => [userProfileEntity,token];
}
class ProfileInitial extends ProfileState {
}
class NoInternetSate extends ProfileState {}

class UserProfileLoadingState extends ProfileState {
   UserProfileLoadingState(ProfileState currentState):super(
    userProfileEntity: currentState.userProfileEntity,
    token: currentState.token

  );
}
class UserProfileLoadedState extends ProfileState {
    UserProfileLoadedState(ProfileState currentState):super(
       userProfileEntity: currentState.userProfileEntity,
       token: currentState.token

   );
}

class ProfileErrorState extends ProfileState {
  final Failure failure;
   ProfileErrorState(ProfileState currentState,{required this.failure}):super(
      userProfileEntity: currentState.userProfileEntity,
      token: currentState.token

  );

}
