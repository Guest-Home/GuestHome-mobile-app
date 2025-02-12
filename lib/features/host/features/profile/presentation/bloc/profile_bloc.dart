import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/core/utils/get_token.dart';
import 'package:minapp/features/host/features/profile/domain/entities/user_profile_entity.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_user_profile_usecase.dart';
import '../../../../../../core/utils/connectivity_service.dart';
import '../../../../../../service_locator.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetUserProfileEvent>((event, emit) async {
      emit(UserProfileLoadingState(state));
      final hasConnection = await ConnectivityService.isConnected();
      if (!hasConnection) {
        Either response = await sl<GetUserProfileUseCase>().call();
        String? token = await GetToken().getUserToken();
        response.fold(
                (l) => emit(ProfileErrorState(state, failure: l)),
                (r) {
              emit(ProfileInitial());
              emit(state.copyWith(userProfileEntity: r, token: token));
            }
        );
      }else{
        emit(NoInternetSate());
      }
    });

    on<ResetProfileEvent>((event, emit) {
      emit(ProfileInitial());
    },);


  }
}
