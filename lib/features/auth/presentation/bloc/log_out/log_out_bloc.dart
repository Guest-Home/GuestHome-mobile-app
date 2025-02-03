import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:minapp/core/error/failure.dart';
import 'package:minapp/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/utils/get_device_id.dart';
import '../../../../../service_locator.dart';

part 'log_out_event.dart';
part 'log_out_state.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  LogOutBloc() : super(LogOutInitial()) {
    on<UserLogoutEvent>((event, emit)async {
      emit(LogOutLoadingState());
      String deviceId=await GetDeviceId().getId();
      Map<String,dynamic> data={
        "device_id":deviceId
      };
      Either response=await sl<LogOutUseCase>().call(data);
      response.fold((l) =>emit(LogOutErrorState(failure: l)) , (r){
        emit(LogOutLoadedState());
        _removeTokens();
      },);

    });
    on<DeactivateEvent>((event, emit)async {
      emit(DeactivateLoadingState());
      String deviceId=await GetDeviceId().getId();
      Map<String,dynamic> data={
        "device_id":deviceId
      };
      Either response=await sl<LogOutUseCase>().call(data);
      response.fold((l) =>emit(LogOutErrorState(failure: l)) , (r){
        emit(DeactivatedState());
        _removeTokens();
      },);
    });
  }

  Future<void> _removeTokens() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove("isLogin");
    await sharedPreferences.remove('access');
    await sharedPreferences.remove('refresh');
    // await sharedPreferences.clear();
  }
}
