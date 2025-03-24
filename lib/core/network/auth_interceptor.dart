import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/core/apiConstants/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    List<String> authRequiredEndpoints = [
      '/hostapp/api/v1/amenities/',
      '/hostapp/api/v1/cities/',
      '/guestapp/api/v1/properties_by_type/',
      '/guestapp/api/v1/property_trending/',
      '/guestapp/api/v1/filter_properties/',
      '/guestapp/api/v1/search_properties/',
      '/hostapp/api/v1/property_types/',
      'authapp/api/v1/otp/'
    ];
    bool requiresAuth = authRequiredEndpoints.any((endpoint) => options.path.contains(endpoint));
    if (!requiresAuth) {
      // Retrieve the token from local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('access'); // Replace with your key
      // If the token is not null, add it to the headers
      if (authToken != null) {
        options.headers['Authorization'] = 'Bearer $authToken';
      }
    }
    // Proceed with the request
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    List<String> requireAccountEndPoint = [
      '/guestapp/api/v1/property_booking/',
      '/hostapp/api/v1/customer/',
    ];
    // Check for 401 Unauthorized error
    if (err.response?.statusCode == 401) {
      // Attempt to refresh the token
      final newToken = await _refreshToken();
      if (newToken != null) {
        // Update the request header with the new token
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        // Retry the original request
        try {
          final response = await Dio().fetch(err.requestOptions);
          return handler.resolve(response);
        } on DioException catch (retryError) {
          return handler.reject(retryError);
        }
      } else {
        // If token refresh fails, redirect to login
        _redirectToLogin();
        return handler.reject(err);
      }
    }
    else if(err.response?.statusCode==404){
      bool requiresAuth = requireAccountEndPoint.any((endpoint) => err.requestOptions.path.contains(endpoint));
      if(requiresAuth){
        final context = navigatorKey.currentContext;
        if (context != null) {
          GoRouter.of(context).goNamed('profileSetup');
        } else {
          debugPrint('Navigator context is null. Ensure the app is fully initialized.');
        }
      }

    }

    // Pass other errors to the next handler
    return handler.next(err);
  }

  Future<String?> _refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refresh'); // Replace with your key
    if (refreshToken == null) {
      return null; // No refresh token available
    }

    // Make a request to refresh the token
    try {
      if (kDebugMode) {
        print("get refresh token");
      }
      final response = await Dio().post(
        ApiUrl.baseUrl +
            ApiUrl.refresh, // Replace with your refresh token endpoint
        data: {'refresh': refreshToken},
      );
      if (kDebugMode) {
        print(response.data);
        print('acesss');
        print(response.data);
      }

      // Assuming the new token is in the response
      String newToken = response.data['access']; // Adjust based on your API response
      // String refreshTo = response.data['refresh'];
      print("newww: ${newToken}");// Adjust based on your API response
    //  print("new ref: ${refreshTo}");// Adjust based on your API response
      await prefs.setString('access', newToken); // Store the new token
     // await prefs.setString('refresh', refreshTo); // Store the new token

     // await sharedPreferences.setBool('isLogin', true);

      return newToken;
    } catch (e) {
      // Handle error (e.g., log it, clear tokens, etc.)
       if (kDebugMode) {
         print(e);
       }
      return null;
    }
  }

  void _redirectToLogin() {
    // Use a global key or context to access GoRouter
    final context = navigatorKey.currentContext;
    if (context != null) {
      GoRouter.of(context).goNamed('signIn');
    } else {
      debugPrint('Navigator context is null. Ensure the app is fully initialized.');
    }
  }
}
