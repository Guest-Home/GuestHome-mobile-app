part of 'update_profile_bloc.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState({
    this.profilePhoto,
  });

  final XFile? profilePhoto;
  UpdateProfileState copyWith({
    XFile? profilePhoto
  }){
    return UpdateProfileState(
        profilePhoto: profilePhoto??this.profilePhoto
    );
  }

  @override
  List<Object> get props => [profilePhoto ?? XFile('')];
}

final class UpdateProfileInitial extends UpdateProfileState {
  @override
  List<Object> get props => [];
}

class ImagePickerError extends UpdateProfileState {
  final String error;
  ImagePickerError(UpdateProfileState currentState, this.error)
      : super(
      profilePhoto: currentState.profilePhoto);

  @override
  List<Object> get props => super.props + [error];
}
class UpdateProfileError extends UpdateProfileState {
  final Failure failure;
  UpdateProfileError(UpdateProfileState currentState, this.failure)
      : super(
      profilePhoto: currentState.profilePhoto);

  @override
  List<Object> get props => super.props + [failure];
}
class UpdateUserProfileLoadingState extends UpdateProfileState {
  UpdateUserProfileLoadingState(UpdateProfileState currentState,)
      : super(
      profilePhoto: currentState.profilePhoto);


}
class UpdateUserProfileLoadedState extends UpdateProfileState {
  final bool isUpdate;
  const UpdateUserProfileLoadedState({required this.isUpdate});
  @override
  List<Object> get props => [isUpdate];
}