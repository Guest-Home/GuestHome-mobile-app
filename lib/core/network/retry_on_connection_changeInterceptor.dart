import 'package:dio/dio.dart';
import '../utils/connectivity_service.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      // Wait for the connection to be restored
      final connectivityResult = await ConnectivityService.isConnected();
      if (connectivityResult) {
        // Retry the request
        try {
          final response = await Dio().fetch(err.requestOptions);
          return handler.resolve(response);
        } on DioException catch (retryError) {
          return handler.reject(retryError);
        }
      }
    }
    // If no retry, pass the error to the next handler
    return handler.next(err);
  }
}
