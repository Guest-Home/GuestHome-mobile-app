import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onbording_state.dart';

class OnbordingCubit extends Cubit<OnbordingState> {
  OnbordingCubit() : super(OnbordingInitial());
}
