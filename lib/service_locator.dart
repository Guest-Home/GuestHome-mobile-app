import 'package:get_it/get_it.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/onbording/presentation/bloc/on_bording_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  //Bloc
  getIt.registerFactory<OnBordingBloc>(() => OnBordingBloc());
  getIt.registerFactory<AddPropertyBloc>(() => AddPropertyBloc());
}
