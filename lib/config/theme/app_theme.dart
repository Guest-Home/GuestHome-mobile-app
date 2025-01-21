import 'package:flutter/material.dart';
import 'package:minapp/config/color/color.dart';

final ThemeData appLightTheme = ThemeData(
  fontFamily: 'Manrope',
  colorScheme: ColorScheme.light(primary: ColorConstant.primaryColor),
  primaryColor: ColorConstant.primaryColor,
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    centerTitle: false,
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15)),
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
);
