import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:minapp/config/route/route.dart';
import 'package:minapp/config/theme/app_theme.dart';
import 'package:minapp/core/common/bloc/internet_connection_bloc/connectivity_bloc.dart';
import 'package:minapp/core/common/bloc/internet_connection_bloc/connectivity_event.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minapp/features/auth/presentation/bloc/log_out/log_out_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/change_phone_number/change_phone_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/deposit_transaction_bloc/deposit_transaction_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/payment_config/payment_config_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/payment_setting_bloc/payment_setting_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/amenities/amenities_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/city/city_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';
import 'package:minapp/features/search/presentation/bloc/search_bloc.dart';
import 'package:minapp/service_locator.dart';
import 'package:path_provider/path_provider.dart';
import 'core/utils/custom_local_delegate.dart';
import 'features/guest/features/HousType/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'features/guest/features/booked/presentation/bloc/booked_bloc.dart';
import 'features/guest/features/booked/presentation/bloc/guest_payment/guest_payment_bloc.dart';
import 'features/host/features/profile/presentation/bloc/booking_history_bloc/booking_history_bloc.dart';
import 'features/host/features/profile/presentation/bloc/profile_bloc.dart';
import 'features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'features/host/features/properties/presentation/bloc/properties_bloc.dart';
import 'features/host/features/request/presentation/bloc/request_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  if(kDebugMode){
    Bloc.observer=MyBlocObserver();
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final GoRouter router = await createRouter(); // Initialize the router

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('am', 'ET'),
      Locale('om', 'ET'),
    ],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    saveLocale: true,
    child: MyApp(router: router),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});
  final GoRouter router;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => sl<ConnectivityBloc>()..add(CheckConnectivity()),
        // ),
        BlocProvider(
          create: (context) => sl<LanguageBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(create: (context) => sl<AddPropertyBloc>()),
        BlocProvider(create: (context) => sl<ChangePhoneBloc>()),
        BlocProvider(create: (context) => sl<LogOutBloc>()),
        BlocProvider(
          create: (context) => sl<BookedBloc>()..add(GetMyBookingEvent()),
        ),
        BlocProvider(
          create: (context) => sl<PropertiesBloc>()..add(GetPropertiesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<PropertyTypeBloc>()..add(GetPropertyTypesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<AmenitiesBloc>()..add(GetAmenityEvent()),
        ),
        BlocProvider(
          // lazy: false,
          create: (context) => sl<CityBloc>()..add(GetCitiesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<ProfileBloc>()..add(GetUserProfileEvent()),
        ),
        BlocProvider(
          create: (context) => sl<FilterBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PaymentSettingBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PaymentConfigBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<DepositTransactionBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<RequestBloc>()..add(GetReservationEvent()),
        ),
        BlocProvider(
          create: (context) => sl<UpdateProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GuestPaymentBloc>(),
        ),
      BlocProvider(create: (context) => sl<BookingHistoryBloc>()..add(GetBookingHistoryEvent()))
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          context.setLocale(state.locale);
          return MaterialApp.router(
              localizationsDelegates: [
                ...context.localizationDelegates,
                EasyLocalization.of(context)!.delegate,
                CustomMaterialLocalizationsDelegate(),
                CustomCupertinoLocalizationsDelegate()
              ],
              locale: state.locale,
              supportedLocales: context.supportedLocales,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              title: 'GuestHome',
              theme: appLightTheme);
        },
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('${bloc.runtimeType} $change');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      print('${bloc.runtimeType} $transition');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('${bloc.runtimeType} $error $stackTrace');
    }
    super.onError(bloc, error, stackTrace);
  }
}
