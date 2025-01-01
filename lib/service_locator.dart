import 'package:get_it/get_it.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';
import 'package:minapp/core/network/dio_client.dart';
import 'package:minapp/features/auth/data/datasources/apiDataSource/api_data_source.dart';
import 'package:minapp/features/auth/data/repositories/otp_repository_impl.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';
import 'package:minapp/features/auth/domain/usecases/create_otp_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/onbording/presentation/bloc/on_bording_bloc.dart';

import 'features/auth/domain/usecases/create_customer_profile_usecase.dart';

final sl = GetIt.instance;
void setup() async {
  //Bloc
  sl.registerFactory<LanguageBloc>(() => LanguageBloc());
  sl.registerFactory<OnBordingBloc>(() => OnBordingBloc());
  sl.registerFactory<AddPropertyBloc>(() => AddPropertyBloc());
  sl.registerFactory<AuthBloc>(() => AuthBloc());

  // usecase

  sl.registerSingleton<CreateOtpUsecase>(CreateOtpUsecase());
  sl.registerSingleton<VerifyOtpUsecase>(VerifyOtpUsecase());
  sl.registerSingleton<CreateCustomerProfileUsecase>(
      CreateCustomerProfileUsecase());

  // repository

  sl.registerSingleton<OtpRepository>(OtpRepositoryImpl());

  // data source

  sl.registerSingleton<ApiDataSource>(ApiDataSourceImpl());

  //dio client
  sl.registerSingleton<DioClient>(DioClient());
}
