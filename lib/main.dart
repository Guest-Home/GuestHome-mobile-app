import 'package:flutter/material.dart';
import 'package:minapp/config/color/color.dart';
import 'package:minapp/config/route/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Min App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorConstant.primaryColor),
        useMaterial3: true,
      ),
    );
  }
}
