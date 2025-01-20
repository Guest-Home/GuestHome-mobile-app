import 'package:dio/dio.dart';
import '../utils/connectivity_service.dart';



class RetryOnConnectionChangeInterceptor extends Interceptor {
  final ConnectivityService connectivityService;

  RetryOnConnectionChangeInterceptor(this.connectivityService);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler)async{
    if (err.type == DioExceptionType.connectionError) {
      final hasConnection = await connectivityService.connectionStatusStream.firstWhere((status) => status);
      if (hasConnection) {
        // Retry the request
        handler.resolve(await err.requestOptions.extra['retry']);
      } else {
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

}
