import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/utils/get_token.dart';
import 'package:minapp/features/host/features/profile/domain/entities/user_profile_entity.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/update_user_profile_usecase.dart';

import '../../../../../../service_locator.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetUserProfileEvent>((event, emit)async{
       emit(UserProfileLoadingState());
       Either response=await sl<GetUserProfileUseCase>().call();
       final token=await GetToken().getUserToken();
       response.fold((l) => emit(ProfileErrorState(l)),(r){
         emit(UserProfileLoadedState(r,token));
       });
      
    });
    on<UpdateUserProfileEvent>((event, emit)async{
      emit(UpdateUserProfileLoadingState());
      Either response=await sl<UpdateUserProfileUseCase>().call(event.userData);
      response.fold((l) =>emit(ProfileErrorState(l)),(r){
        emit(UpdateUserProfileState(isUpdate: r));
      });
    });

  }


}
