import 'package:get_it/get_it.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';
import 'package:minapp/core/network/dio_client.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/onbording/presentation/bloc/on_bording_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  //Bloc
  getIt.registerFactory<LanguageBloc>(() => LanguageBloc());
  getIt.registerFactory<OnBordingBloc>(() => OnBordingBloc());
  getIt.registerFactory<AddPropertyBloc>(() => AddPropertyBloc());

  //dio client
  getIt.registerSingleton<DioClient>(DioClient());
}
