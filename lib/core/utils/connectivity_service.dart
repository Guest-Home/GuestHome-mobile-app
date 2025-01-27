import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectivityStreamController =
      StreamController<bool>.broadcast();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((event) {
      _updateConnectionStatus(event);
    });
  }

  Stream<bool> get connectionStatusStream =>
      _connectivityStreamController.stream;

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    final hasConnection = result.contains(ConnectivityResult.none);
    _connectivityStreamController.add(!hasConnection);
  }

  void dispose() {
    _connectivityStreamController.close();
  }

  static Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.none);
  }
}
