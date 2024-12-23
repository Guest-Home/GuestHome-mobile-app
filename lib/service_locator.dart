import 'package:get_it/get_it.dart';
import 'package:minapp/features/onbording/presentation/bloc/on_bording_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerFactory<OnBordingBloc>(() => OnBordingBloc());
}
