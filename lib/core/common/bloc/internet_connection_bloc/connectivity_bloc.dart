import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckConnectivity>(_checkConnection);
    // Start listening to connection changes
    _subscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      // Received changes in available connectivity types!
      add(CheckConnectivity());
    });
    // _connectivity.onConnectivityChanged.listen((result) {
    //   add(CheckConnectivity());
    // }) as StreamSubscription<ConnectivityResult>;
    // Initial check
    add(CheckConnectivity());
  }

  Future<void> _checkConnection(
      CheckConnectivity event, Emitter<ConnectivityState> emit) async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      emit(Disconnected());
    } else {
      emit(Connected());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel(); // Clean up the listener
    return super.close();
  }
}
