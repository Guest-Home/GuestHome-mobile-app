import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/config/route/route.dart';
import 'package:minapp/core/common/bloc/language_bloc.dart';
import 'package:minapp/features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import 'package:minapp/service_locator.dart';
import 'features/onbording/presentation/bloc/on_bording_bloc.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
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
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
            theme: ThemeData(
              fontFamily: 'Manrope',
              colorScheme:
                  ColorScheme.fromSeed(seedColor: ColorConstant.primaryColor),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.all(15)),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Colors.white,
                  ),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
