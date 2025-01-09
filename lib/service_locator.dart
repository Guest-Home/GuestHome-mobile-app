import 'package:get_it/get_it.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';
import 'package:minapp/core/network/dio_client.dart';
import 'package:minapp/core/utils/connectivity_service.dart';
import 'package:minapp/features/auth/data/datasources/apiDataSource/api_data_source.dart';
import 'package:minapp/features/auth/data/repositories/otp_repository_impl.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';
import 'package:minapp/features/auth/domain/usecases/create_otp_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minapp/features/host/features/analytics/data/datasources/analytics-data_source,dart.dart';
import 'package:minapp/features/host/features/analytics/data/repositories/occupancy_rate_repository_impl.dart';
import 'package:minapp/features/host/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/get_custom_occup_usecase.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/get_occupancy_rate_usecase.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/get_total_property_usecase.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/total_property_bloc.dart';
import 'package:minapp/features/host/features/profile/data/datasources/user_proile_datasource.dart';
import 'package:minapp/features/host/features/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:minapp/features/host/features/properties/data/datasources/property_api_data_source.dart';
import 'package:minapp/features/host/features/properties/data/repositories/amenity_repository_impl.dart';
import 'package:minapp/features/host/features/properties/data/repositories/city_repository_impl.dart';
import 'package:minapp/features/host/features/properties/data/repositories/property_repository_impl.dart';
import 'package:minapp/features/host/features/properties/data/repositories/property_type_repository_impl.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/amenity_repository.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/city_repository.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_repository.dart';
import 'package:minapp/features/host/features/properties/domain/repositories/property_type_repository.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/create_property_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_amenity_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_cities_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_properties_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_property_type_usecase.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/amenities/amenities_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/city/city_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/properties_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';
import 'package:minapp/features/host/features/request/data/datasources/reservation_remote_api.dart';
import 'package:minapp/features/host/features/request/data/repositories/reservation_repository_impl.dart';
import 'package:minapp/features/host/features/request/domain/repositories/reservation_repository.dart';
import 'package:minapp/features/host/features/request/domain/usecases/accept_reserv_usecase.dart';
import 'package:minapp/features/host/features/request/domain/usecases/get_reservation_usecase.dart';
import 'package:minapp/features/host/features/request/domain/usecases/reject-reserv_usecase.dart';
import 'package:minapp/features/host/features/request/presentation/bloc/request_bloc.dart';
import 'package:minapp/features/onbording/presentation/bloc/on_bording_bloc.dart';

import 'features/auth/domain/usecases/create_customer_profile_usecase.dart';

final sl = GetIt.instance;
void setup() async {
  // connectivity service
  sl.registerSingleton<ConnectivityService>(ConnectivityService());
  //Bloc
  sl.registerFactory<LanguageBloc>(() => LanguageBloc());
  sl.registerFactory<OnBordingBloc>(() => OnBordingBloc());
  sl.registerFactory<AddPropertyBloc>(() => AddPropertyBloc());
  sl.registerFactory<AuthBloc>(() => AuthBloc());
  sl.registerFactory<AnalyticsBloc>(() => AnalyticsBloc());
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
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(),);
  sl.registerFactory<RequestBloc>(() => RequestBloc(),);
  sl.registerFactory<TotalPropertyBloc>(() => TotalPropertyBloc(),);

  // usecase

  sl.registerSingleton<CreateOtpUsecase>(CreateOtpUsecase());
  sl.registerSingleton<VerifyOtpUsecase>(VerifyOtpUsecase());
  sl.registerSingleton<CreateCustomerProfileUsecase>(
      CreateCustomerProfileUsecase());
  sl.registerSingleton<UpdateUserProfileUseCase>(UpdateUserProfileUseCase());
  sl.registerSingleton<GetPropertiesUsecase>(GetPropertiesUsecase());
  sl.registerSingleton<CreatePropertyUsecase>(CreatePropertyUsecase());
  sl.registerSingleton<GetPropertyTypeUsecase>(GetPropertyTypeUsecase());
  sl.registerSingleton<GetAmenityUsecase>(GetAmenityUsecase());
  sl.registerSingleton<GetCitiesUsecase>(GetCitiesUsecase());
  sl.registerSingleton<GetUserProfileUseCase>(GetUserProfileUseCase());
  sl.registerSingleton<GetRservationUseCase>(GetRservationUseCase());
  sl.registerSingleton<AcceptReservationUsecase>(AcceptReservationUsecase());
  sl.registerSingleton<RejecctReservationUseCase>(RejecctReservationUseCase());
  sl.registerSingleton<GetOccupancyRateUseCase>(GetOccupancyRateUseCase());
  sl.registerSingleton<GetTotalPropertyUsecase>(GetTotalPropertyUsecase());
  sl.registerSingleton<GetCustomOccupancyUseCase>(GetCustomOccupancyUseCase());


  // repository

  sl.registerSingleton<OtpRepository>(OtpRepositoryImpl());
  sl.registerSingleton<PropertyRepository>(PropertyRepositoryImpl());
  sl.registerSingleton<PropertyTypeRepository>(PropertyTypeRepositoryImpl());
  sl.registerSingleton<AmenityRepository>(AmenityRepositoryImpl());
  sl.registerSingleton<CityRepository>(CityRepositoryImpl());
  sl.registerSingleton<UserProfileRepository>(UserProfileRepositoryImple());
  sl.registerSingleton<ReservationRepository>(ReservationRepositoryImpl());
  sl.registerSingleton<AnalyticsRepository>(OccupancyRateRepositoryImpl());

  // data source

  sl.registerSingleton<ApiDataSource>(ApiDataSourceImpl());
  sl.registerSingleton<PropertyApiDataSource>(PropertyApiDataSourceImpl());
  sl.registerSingleton<UserProfileDataSource>(UserProfileDataSourceImple());
  sl.registerSingleton<ReservationApiDataSource>(ReservationApiDataSourceImpl());
  sl.registerSingleton<AnalyticsDataSource>(AnalyticsDataSourceImpl());

  //dio client
  sl.registerSingleton<DioClient>(DioClient());
}
