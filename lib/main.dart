import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/route/route.dart';
import 'package:minapp/config/theme/app_theme.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';
import 'package:minapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/amenities/amenities_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/city/city_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/property_type/property_type_bloc.dart';
import 'package:minapp/service_locator.dart';
import 'features/host/features/profile/presentation/bloc/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  // Bloc.observer=MyBlocObserver();
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
      saveLocale: false,
      child: MyApp(router: router)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});
  final GoRouter router;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LanguageBloc>(),
        ),

        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        //  BlocProvider(create: (context) => sl<AddPropertyBloc>()),
        // BlocProvider(
        //   create: (context) => sl<PropertiesBloc>(),
        // ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              sl<PropertyTypeBloc>()..add(GetPropertyTypesEvent()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => sl<AmenitiesBloc>()..add(GetAmenityEvent()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => sl<CityBloc>()..add(GetCitiesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<ProfileBloc>()..add(GetUserProfileEvent()),
        )
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        buildWhen: (previous, current) => previous.locale != current.locale,
        builder: (context, state) {
          return MaterialApp.router(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                EasyLocalization.of(context)!.delegate,
              ],
              supportedLocales: context.supportedLocales,
              locale: state.locale,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              title: 'Min App',
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
