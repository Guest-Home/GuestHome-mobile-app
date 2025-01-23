import 'package:dio/dio.dart';
import 'package:minapp/core/apiConstants/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Retrieve the token from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('access'); // Replace with your key

    // If the token is not null, add it to the headers
    if (authToken != null) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    // Proceed with the request
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // If the response indicates that the token has expired (e.g., 401 Unauthorized)
    if (response.statusCode == 401) {
      // Attempt to refresh the token
      final newToken = await _refreshToken();
      if (newToken != null) {
        // Update the request with the new token
        response.requestOptions.headers['Authorization'] = 'Bearer $newToken';

        // Retry the request
        final retryResponse = await Dio().fetch(response.requestOptions);
        return handler.resolve(retryResponse);
      }
    }
    return super.onResponse(response, handler);
  }

  Future<String?> _refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refresh'); // Replace with your key

    if (refreshToken == null) {
      return null; // No refresh token available
    }

    // Make a request to refresh the token
    try {
      final response = await Dio().post(
        ApiUrl.baseUrl+ApiUrl.refresh, // Replace with your refresh token endpoint
        data: {'refresh': refreshToken},
      );

      // Assuming the new token is in the response
      String newToken =response.data['access']; // Adjust based on your API response
      String refreshTo =response.data['refresh']; // Adjust based on your API response
      await prefs.setString('access', newToken); // Store the new token
      await prefs.setString('refresh', refreshTo); // Store the new token
      return newToken;
    } catch (e) {
      // Handle error (e.g., log it, clear tokens, etc.)
      return null;
    }
  }
}
