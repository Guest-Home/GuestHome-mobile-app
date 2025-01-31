
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
        if (e.response?.statusCode == 500) {
          return UnauthorizedFailure(e.response?.statusMessage?? 'Server error');
        }
        if (e.response?.statusCode == 502) {
          return UnauthorizedFailure(e.response?.statusMessage ?? 'Server error');
        }
        if (e.response?.statusCode == 413) {
          return UnauthorizedFailure(e.response?.statusMessage ?? 'Client error');
        }
        if (e.response?.statusCode == 404) {
          return UnauthorizedFailure(e.response?.statusMessage ?? 'Client error');
        }
        return ServerFailure(e.response?.statusMessage ?? 'Server error occurred');
        //return ServerFailure(e.response?.data['Error'] ?? 'Server error occurred');
      case DioExceptionType.cancel:
        return NetworkFailure('Request was cancelled');

      default:
        return UnknownFailure('An unexpected error occurred: ${e.message}');
    }
  }
}