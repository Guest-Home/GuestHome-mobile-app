import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:minapp/core/network/auth_interceptor.dart';
import 'package:minapp/core/network/retry_on_connection_changeInterceptor.dart';
import '../apiConstants/api_url.dart';
import 'log_intercepters.dart';

class DioClient {
  late final Dio _dio;
  DioClient()
      : _dio = Dio(
          BaseOptions(
              baseUrl: ApiUrl.baseUrl,
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-api-key': ApiUrl.apiKey,
              },
              responseType: ResponseType.json,
              sendTimeout: const Duration(seconds: 20),
              receiveTimeout: const Duration(seconds: 20)),
        ){
    // Configure SSL Handling
    _initializeSSL();

    // Add Interceptors
    _dio.interceptors.addAll([
      AuthInterceptor(),
      LoggerInterceptor(),
      RetryOnConnectionChangeInterceptor(),
    ]);
  }

  /// Initialize SSL configuration for Dio
  Future<void> _initializeSSL() async {
    try {
      final ByteData sslCert = await rootBundle.load('assets/certificates/fullchain.pem');
      SecurityContext context = SecurityContext.defaultContext;
      context.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

      // Set up Dio's HTTP client adapter with the SSL context
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        return HttpClient(context: context);
      };
    } catch (e) {
      print("SSL Certificate Error: $e");
    }
  }
    // ..interceptors.addAll([
    //         AuthInterceptor(),
    //         LoggerInterceptor(),
    //         RetryOnConnectionChangeInterceptor(),
    //       ]);



  // DOWNLOAD METHOD
  Future<Response> download(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.download(
        url,
        savePath,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PATCH METHOD
  Future<Response> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
