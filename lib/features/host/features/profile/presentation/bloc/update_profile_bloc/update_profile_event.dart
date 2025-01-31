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
class UpdateUserProfileEvent extends UpdateProfileEvent{
  final Map<String,dynamic> userData;
  const UpdateUserProfileEvent({required this.userData});

  @override
  List<Object?> get props =>[userData];
}