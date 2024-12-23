import 'package:go_router/go_router.dart';
import 'package:minapp/config/route/navigator_observer.dart';
import 'package:minapp/features/onbording/presentation/pages/onbording.dart';

final GoRouter router = GoRouter(
  observers: [MyNavigatorObserver()],
  initialLocation: '/',
  routes: [
    GoRoute(
        name: 'onboarding',
        path: '/',
        builder: (context, state) =>OnBording()),

  ],
);
