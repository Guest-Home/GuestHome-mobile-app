import 'package:go_router/go_router.dart';
import 'package:minapp/features/onbording/presentation/pages/onbording.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) =>OnBording()),

  ],
);
