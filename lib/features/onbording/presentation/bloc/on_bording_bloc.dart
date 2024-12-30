import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'on_bording_event.dart';
part 'on_bording_state.dart';

class OnBordingBloc extends Bloc<OnBordingEvent, OnBordingState> {
  OnBordingBloc() : super(OnBordingState()) {
    on<OnBordingChangeEvent>((event, emit) {
      if (state.progress == 1.0) {
        emit(state.copyWith(progress: 0.2, index: 0));
      } else {
        emit(state.copyWith(
            index: state.index + 1, progress: state.progress + 0.2));
      }
    });

    on<OnBordingGetStartedEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isFirstTimeUser", false);
      emit(GetStartedState());
    });
  }
}
