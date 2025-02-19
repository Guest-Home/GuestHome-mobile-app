part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();
}

class SelectPictureUpdateEvent extends UpdateProfileEvent{
  @override
  List<Object?> get props =>[];

}
class RemovePictureUpdateEvent extends UpdateProfileEvent{
  @override
  List<Object?> get props =>[];

}
class ResetUpdateEvent extends UpdateProfileEvent{
  @override
  List<Object?> get props =>[];

}
class UpdateUserProfileEvent extends UpdateProfileEvent{
  final Map<String,dynamic> userData;
  const UpdateUserProfileEvent({required this.userData});

  @override
  List<Object?> get props =>[userData];
}

class UpdateUserLanguageEvent extends UpdateProfileEvent{
  final String appLocal;

  @override
  List<Object?> get props =>[appLocal];
  const UpdateUserLanguageEvent(this.appLocal);
}