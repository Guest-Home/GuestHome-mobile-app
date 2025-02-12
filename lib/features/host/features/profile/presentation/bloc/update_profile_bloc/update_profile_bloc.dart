import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minapp/core/error/failure.dart';

import '../../../../../../../core/utils/connectivity_service.dart';
import '../../../../../../../core/utils/file_picker.dart';
import '../../../../../../../service_locator.dart';
import '../../../domain/usecases/update_user_profile_usecase.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitial()) {

    on<UpdateUserProfileEvent>((event, emit) async {
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        emit(UpdateUserProfileLoadingState(state));
        Map<String,dynamic> data={
          "first_name":event.userData['first_name'],
          "last_name":event.userData['last_name'],
          if(state.profilePhoto!=null)
            "image":state.profilePhoto
        };
        Either response = await sl<UpdateUserProfileUseCase>().call(data);
        response.fold((l) => emit(UpdateProfileError(state,l)), (r) {
          emit(UpdateUserProfileLoadedState(isUpdate: r));
        });
      }

    });
    on<ResetUpdateEvent>((event, emit) => emit(UpdateProfileInitial()),);

    on<SelectPictureUpdateEvent>((event, emit) async {
      try {
        final XFile? image = await FilePicker().picImage();
        if (image != null) {
          emit(state.copyWith(profilePhoto: image));
        } else {
          emit(ImagePickerError(state, 'No image selected.'));
        }
      } catch (e) {
        emit(ImagePickerError(state, 'Failed to pick an image'));
      }
    });
    on<RemovePictureUpdateEvent>((event, emit) async {
          emit(state.copyWith(profilePhoto: XFile('')));

    });
  }
}
