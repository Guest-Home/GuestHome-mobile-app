import 'package:get_it/get_it.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';
import 'package:minapp/core/network/dio_client.dart';
import 'package:minapp/features/auth/data/datasources/apiDataSource/api_data_source.dart';
import 'package:minapp/features/auth/data/repositories/otp_repository_impl.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';
import 'package:minapp/features/auth/domain/usecases/create_otp_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minapp/features/host/features/properties/data/datasources/property_api_data_source.dart';
import 'package:minapp/features/host/features/properties/data/repositories/amenity_repository_impl.dart';
import 'package:minapp/features/host/features/properties/data/repositories/city_repository_impl.dart';
import 'package:minapp/features/host/features/properties/data/repositories/property_repository_impl.dart';
import 'package:minapp/features/host/features/properties/data/repositories/property_type_repository_impl.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/amenity_repository.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/city_repository.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_repository.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_type_repository.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_amenity_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_cities_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_properties_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_property_type_usecase.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/amenities/amenities_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/city/city_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/properties_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';
import 'package:minapp/features/onbording/presentation/bloc/on_bording_bloc.dart';

import 'features/auth/domain/usecases/create_customer_profile_usecase.dart';

final sl = GetIt.instance;
void setup() async {
  //Bloc
  sl.registerFactory<LanguageBloc>(() => LanguageBloc());
  sl.registerFactory<OnBordingBloc>(() => OnBordingBloc());
  sl.registerFactory<AddPropertyBloc>(() => AddPropertyBloc());
  sl.registerFactory<AuthBloc>(() => AuthBloc());
  sl.registerFactory<PropertiesBloc>(() => PropertiesBloc());
  sl.registerFactory<PropertyTypeBloc>(
    () => PropertyTypeBloc(),
  );
  sl.registerFactory<AmenitiesBloc>(
    () => AmenitiesBloc(),
  );
  sl.registerFactory<CityBloc>(
    () => CityBloc(),
  );

  // usecase

  sl.registerSingleton<CreateOtpUsecase>(CreateOtpUsecase());
  sl.registerSingleton<VerifyOtpUsecase>(VerifyOtpUsecase());
  sl.registerSingleton<CreateCustomerProfileUsecase>(
      CreateCustomerProfileUsecase());
  sl.registerSingleton<GetPropertiesUsecase>(GetPropertiesUsecase());
  sl.registerSingleton<GetPropertyTypeUsecase>(GetPropertyTypeUsecase());
  sl.registerSingleton<GetAmenityUsecase>(GetAmenityUsecase());
  sl.registerSingleton<GetCitiesUsecase>(GetCitiesUsecase());

  // repository

  sl.registerSingleton<OtpRepository>(OtpRepositoryImpl());
  sl.registerSingleton<PropertyRepository>(PropertyRepositoryImpl());
  sl.registerSingleton<PropertyTypeRepository>(PropertyTypeRepositoryImpl());
  sl.registerSingleton<AmenityRepository>(AmenityRepositoryImpl());
  sl.registerSingleton<CityRepository>(CityRepositoryImpl());

  // data source

  sl.registerSingleton<ApiDataSource>(ApiDataSourceImpl());
  sl.registerSingleton<PropertyApiDataSource>(PropertyApiDataSourceImpl());

  //dio client
  sl.registerSingleton<DioClient>(DioClient());
}
