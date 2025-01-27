import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/connectivity_service.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final ConnectivityService connectivityService;

  RetryOnConnectionChangeInterceptor(this.connectivityService);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
    } else {
      _redirectToNoInternetScreen();
      handler.next(err);
    }
  }

  void _redirectToNoInternetScreen() {
    // Use a global key or context to access GoRouter
    final navigatorKey = GlobalKey<NavigatorState>();
    navigatorKey.currentState?.pushReplacementNamed('/splash');
  }
}
