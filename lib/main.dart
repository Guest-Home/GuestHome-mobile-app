import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/route/route.dart';
import 'package:minapp/config/theme/app_theme.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/service_locator.dart';
import 'features/onbording/presentation/bloc/on_bording_bloc.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
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
          create: (context) => getIt<LanguageBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<OnBordingBloc>(),
        ),
        BlocProvider(create: (context) => getIt<AddPropertyBloc>())
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
