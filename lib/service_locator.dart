import 'package:get_it/get_it.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';
import 'package:minapp/core/network/dio_client.dart';
import 'package:minapp/core/utils/connectivity_service.dart';
import 'package:minapp/features/auth/data/datasources/apiDataSource/api_data_source.dart';
import 'package:minapp/features/auth/data/repositories/otp_repository_impl.dart';
import 'package:minapp/features/auth/domain/repositories/otp_repository.dart';
import 'package:minapp/features/auth/domain/usecases/create_otp_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/deactivate_account_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:minapp/features/auth/domain/usecases/verify_tg_otp_usecase.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minapp/features/auth/presentation/bloc/log_out/log_out_bloc.dart';
import 'package:minapp/features/guest/features/HousType/data/datasources/house_data_source.dart';
import 'package:minapp/features/guest/features/HousType/data/repositories/house_repository_impl.dart';
import 'package:minapp/features/guest/features/HousType/domain/repositories/house_repository.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/filter_property_usecase.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/get_house_bytype_usecase.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/get_popular_property_usecase.dart';
import 'package:minapp/features/guest/features/HousType/domain/usecases/proprty_booking_usecase.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/booking/booking_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/houstype_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/popular_property/popular_property_bloc.dart';
import 'package:minapp/features/guest/features/booked/data/datasources/booking_data_source.dart';
import 'package:minapp/features/guest/features/booked/data/repositories/my_booking_repository_impl.dart';
import 'package:minapp/features/guest/features/booked/domain/repositories/my_booking_repositorty.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/cancel_booking_usecase.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/get_my_booking_usecase.dart';
import 'package:minapp/features/guest/features/booked/domain/usecases/make_payment_usecase.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/booked_bloc.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/booked_detail/booked_detail_bloc.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/guest_payment/guest_payment_bloc.dart';
import 'package:minapp/features/host/features/analytics/data/datasources/analytics_data_source.dart';
import 'package:minapp/features/host/features/analytics/data/repositories/occupancy_rate_repository_impl.dart';
import 'package:minapp/features/host/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/download_report_custom_usecase.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/download_report_usecase.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/get_custom_occup_usecase.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/get_occupancy_rate_usecase.dart';
import 'package:minapp/features/host/features/analytics/domain/usecases/get_total_property_usecase.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/total_property_bloc.dart';
import 'package:minapp/features/host/features/profile/data/datasources/user_proile_datasource.dart';
import 'package:minapp/features/host/features/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:minapp/features/host/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/deposit_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_deposit_transaction_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_otp_new_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_otp_old_phone_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/verify_new_otp_usecase.dart';
import 'package:minapp/features/host/features/profile/domain/usecases/verify_old_otp_usecase.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/change_phone_number/change_phone_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/deposit_transaction_bloc/deposit_transaction_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/payment_config/payment_config_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/payment_setting_bloc/payment_setting_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
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
import 'package:minapp/features/host/features/properties/domain/usecases/delete_property_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_agent_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_amenity_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_cities_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_properties_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/get_property_type_usecase.dart';
import 'package:minapp/features/search/data/repositories/search_repository_impl.dart';
import 'package:minapp/features/search/domain/repositories/search_repository.dart';
import 'package:minapp/features/search/domain/usecases/search_property_usecase.dart';
import 'package:minapp/features/host/features/properties/domain/usecases/update_property_usecase.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/amenities/amenities_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/city/city_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/properties_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/search_property/search_property_bloc.dart';
import 'package:minapp/features/host/features/request/data/datasources/reservation_remote_api.dart';
import 'package:minapp/features/host/features/request/data/repositories/reservation_repository_impl.dart';
import 'package:minapp/features/host/features/request/domain/repositories/reservation_repository.dart';
import 'package:minapp/features/host/features/request/domain/usecases/accept_reserv_usecase.dart';
import 'package:minapp/features/host/features/request/domain/usecases/get_reservation_usecase.dart';
import 'package:minapp/features/host/features/request/domain/usecases/reject_reserv_usecase.dart';
import 'package:minapp/features/host/features/request/presentation/bloc/request_bloc.dart';
import 'package:minapp/features/onbording/presentation/bloc/on_bording_bloc.dart';
import 'package:minapp/features/search/presentation/bloc/search_bloc.dart';

import 'features/auth/domain/usecases/create_customer_profile_usecase.dart';
import 'features/auth/domain/usecases/create_tg_otp_usecase.dart';
import 'features/guest/features/HousType/domain/usecases/filter_next_usecase.dart';
import 'features/guest/features/booked/domain/usecases/get_booking_detail_usecase.dart';
import 'features/host/features/profile/domain/usecases/get_commision_usecase.dart';
import 'features/host/features/profile/domain/usecases/get_payment_config_usecase.dart';
import 'features/host/features/profile/domain/usecases/payment_config_usecase.dart';
import 'features/host/features/profile/domain/usecases/update_user_language_usecase.dart';
import 'features/search/domain/usecases/host_search_property_usecase.dart';

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
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(),
  );
  sl.registerFactory<RequestBloc>(
    () => RequestBloc(),
  );
  sl.registerFactory<TotalPropertyBloc>(
    () => TotalPropertyBloc(),
  );
  sl.registerFactory<SearchPropertyBloc>(
    () => SearchPropertyBloc(),
  );

  sl.registerFactory<HoustypeBloc>(
    () => HoustypeBloc(),
  );
  sl.registerFactory<BookingBloc>(
    () => BookingBloc(),
  );
  sl.registerFactory<PopularPropertyBloc>(
    () => PopularPropertyBloc(),
  );
  sl.registerFactory<FilterBloc>(
    () => FilterBloc(),
  );
  sl.registerFactory<BookedBloc>(
    () => BookedBloc(),
  );
  sl.registerFactory<BookedDetailBloc>(
    () => BookedDetailBloc(),
  );
  sl.registerFactory<ChangePhoneBloc>(
    () => ChangePhoneBloc(),
  );
  sl.registerFactory<LogOutBloc>(
    () => LogOutBloc(),
  );
  sl.registerFactory<SearchBloc>(
    () => SearchBloc(),
  );
  sl.registerFactory<PaymentSettingBloc>(
        () => PaymentSettingBloc(),
  );
  sl.registerFactory<DepositTransactionBloc>(
        () => DepositTransactionBloc(),
  );
  sl.registerFactory<UpdateProfileBloc>(
        () => UpdateProfileBloc(),
  );
  sl.registerFactory<PaymentConfigBloc>(
        () => PaymentConfigBloc(),
  );
  sl.registerFactory<GuestPaymentBloc>(
        () => GuestPaymentBloc(),
  );
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
  sl.registerSingleton<DeletePropertyUsecase>(DeletePropertyUsecase());
  sl.registerSingleton<UpdatePropertyUseCase>(UpdatePropertyUseCase());
  sl.registerSingleton<GetAgentUsecase>(GetAgentUsecase());
  sl.registerSingleton<SearchPropertyUseCase>(SearchPropertyUseCase());
  sl.registerSingleton<HostSearchPropertyUseCase>(HostSearchPropertyUseCase());

  sl.registerSingleton<GetHouseBytypeUsecase>(GetHouseBytypeUsecase());
  sl.registerSingleton<GetPopularPropertyUseCase>(GetPopularPropertyUseCase());
  sl.registerSingleton<PropertyBookingUseCase>(PropertyBookingUseCase());
  sl.registerSingleton<GetMyBookingUseCase>(GetMyBookingUseCase());
  sl.registerSingleton<CancelBookingUseCase>(CancelBookingUseCase());
  sl.registerSingleton<FilterPropertyUseCase>(FilterPropertyUseCase());
  sl.registerSingleton<GetBookingDetailUseCase>(GetBookingDetailUseCase());
  sl.registerSingleton<GetOtpOldPhoneUseCase>(GetOtpOldPhoneUseCase());
  sl.registerSingleton<VerifyOldOtpUseCase>(VerifyOldOtpUseCase());
  sl.registerSingleton<GetOtpForNewUseCase>(GetOtpForNewUseCase());
  sl.registerSingleton<VerifyNewOtpUseCase>(VerifyNewOtpUseCase());
  sl.registerSingleton<LogOutUseCase>(LogOutUseCase());
  sl.registerSingleton<DeactivateAccountUseCase>(DeactivateAccountUseCase());
  sl.registerSingleton<DownloadReportCustomUseCase>(
      DownloadReportCustomUseCase());
  sl.registerSingleton<DownloadReportUseCase>(DownloadReportUseCase());
  sl.registerSingleton<CreateTgOtpUsecase>(CreateTgOtpUsecase());
  sl.registerSingleton<VerifyTgOtpUsecase>(VerifyTgOtpUsecase());
  sl.registerSingleton<DepositUseCase>(DepositUseCase());
  sl.registerSingleton<GetCommissionUseCase>(GetCommissionUseCase());
  sl.registerSingleton<FilterNextUseCase>(FilterNextUseCase());
  sl.registerSingleton<GetDepositTransactionUsecase>(GetDepositTransactionUsecase());
  sl.registerSingleton<PaymentConfigUseCase>(PaymentConfigUseCase());
  sl.registerSingleton<GetPaymentConfigUseCase>(GetPaymentConfigUseCase());
  sl.registerSingleton<MakePaymentUseCase>(MakePaymentUseCase());
  sl.registerSingleton<UpdateUserLanguageUseCase>(UpdateUserLanguageUseCase());

  // repository

  sl.registerSingleton<OtpRepository>(OtpRepositoryImpl());
  sl.registerSingleton<PropertyRepository>(PropertyRepositoryImpl());
  sl.registerSingleton<PropertyTypeRepository>(PropertyTypeRepositoryImpl());
  sl.registerSingleton<AmenityRepository>(AmenityRepositoryImpl());
  sl.registerSingleton<CityRepository>(CityRepositoryImpl());
  sl.registerSingleton<UserProfileRepository>(UserProfileRepositoryImple());
  sl.registerSingleton<ReservationRepository>(ReservationRepositoryImpl());
  sl.registerSingleton<AnalyticsRepository>(OccupancyRateRepositoryImpl());
  sl.registerSingleton<HouseRepository>(HouseRepositoryImpl());
  sl.registerSingleton<MyBookingRepository>(MyBookingRepositoryImpl());
  sl.registerSingleton<SearchRepository>(SearchRepositoryImpl());

  // data source

  sl.registerSingleton<ApiDataSource>(ApiDataSourceImpl());
  sl.registerSingleton<PropertyApiDataSource>(PropertyApiDataSourceImpl());
  sl.registerSingleton<UserProfileDataSource>(UserProfileDataSourceImple());
  sl.registerSingleton<ReservationApiDataSource>(
      ReservationApiDataSourceImpl());
  sl.registerSingleton<AnalyticsDataSource>(AnalyticsDataSourceImpl());
  sl.registerSingleton<HouseDataSource>(HouseDataSourceImpl());
  sl.registerSingleton<BookingDataSource>(BookingDataSourceImpl());

  //dio client
  sl.registerSingleton<DioClient>(DioClient());
}
