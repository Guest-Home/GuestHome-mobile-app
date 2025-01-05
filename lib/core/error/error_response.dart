
import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorResponse{

  Failure mapDioExceptionToFailure(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutFailure('Connection timeout');
      case DioExceptionType.sendTimeout:
        return TimeoutFailure('Send timeout');
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure('Receive timeout');
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 401) {
          return UnauthorizedFailure('Unauthorized access');
        }
        return ServerFailure(e.response?.data['error'] ?? 'Server error occurred');
      case DioExceptionType.cancel:
        return NetworkFailure('Request was cancelled');

      default:
        return UnknownFailure('An unexpected error occurred: ${e.message}');
    }
  }
}