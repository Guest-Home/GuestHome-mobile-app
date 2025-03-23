import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../service_locator.dart';
import '../../utils/show_snack_bar.dart';
import '../bloc/internet_connection_bloc/connectivity_bloc.dart';
import '../bloc/internet_connection_bloc/connectivity_state.dart';

class ConnectivityListener extends StatefulWidget {
  final Widget child;
  final VoidCallback? onConnected;
  final String routeName;
  const ConnectivityListener({super.key, required this.child, this.onConnected,required this.routeName});

  @override
  State<ConnectivityListener> createState() => _ConnectivityListenerState();
}

class _ConnectivityListenerState extends State<ConnectivityListener> {
  bool _hasFetchedData = false; // Track if data is already fetched
  late final ConnectivityBloc connectivityBloc;
  StreamSubscription<ConnectivityState>? _connectivitySubscription;


  @override
  void initState() {
    super.initState();
    connectivityBloc = sl<ConnectivityBloc>();
    _hasFetchedData=true;

    // Ensure API call only on correct route and connection
      _connectivitySubscription = connectivityBloc.stream.listen(_handleConnectivityChange);
      // Initial check (post-frame to ensure accurate state)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (connectivityBloc.state is Connected) {
          _fetchDataIfNeeded();
        }
      });
  }
  void _handleConnectivityChange(ConnectivityState state) {
    if (state is Connected) {
      _fetchDataIfNeeded();
    } else {
      _hasFetchedData=false;
      showNoInternetSnackBar(context,);
    }
  }

  void _fetchDataIfNeeded() {
    final currentLocation = GoRouter.of(context).state!.name;
    if (widget.onConnected != null &&
        currentLocation == widget.routeName &&
        !_hasFetchedData) {
      widget.onConnected!();
      _hasFetchedData = false; // Mark data as fetched
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Back Online'),
          duration: Duration(seconds: 3), // How long the Snackbar is visible
        ),
      );
    }else{
      if (!_hasFetchedData) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Back Online'),
            duration: Duration(seconds: 3), // How long the Snackbar is visible
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityBloc, ConnectivityState>(
      bloc: connectivityBloc,
      listener: (context, state) {
        // if (state is Disconnected) {
        //   Logger().i("Internet Not Connected: ${state}");
        //   showNoInternetSnackBar(context,);
        // }
        // else {
        //   // Trigger API refresh when internet is restored
        //   // if (widget.onConnected != null && GoRouter.of(context).state!.name == widget.routeName && _hasFetchedData) {
        //   //   widget.onConnected!();
        //   //   _hasFetchedData = false;
        //   // }
        //   _fetchDataIfNeeded();
        // }
      },
      builder: (context, state) {
        // if (!state.internetConnected) {
        //   return const NoInternetScreen(); // Optional: Show a no-internet screen.
        // }
        return widget.child; // Rebuild child when internet is restored.
      },
    );
  }
  @override
  void dispose() {
    super.dispose();
    connectivityBloc.close();
    _connectivitySubscription!.cancel();
  }
}
