import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/route/navigator_observer.dart';
import 'package:minapp/features/host/features/analytics/presentation/pages/analytics.dart';
import 'package:minapp/features/host/features/home/presentation/pages/home.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/profile.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/add_properties.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/listed_property_detail.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/properties.dart';
import 'package:minapp/features/host/features/request/presentation/pages/request.dart';
import 'package:minapp/features/onbording/presentation/pages/onbording.dart';

final GoRouter router = GoRouter(
  observers: [MyNavigatorObserver()],
  initialLocation: '/properties',
  routes: [
    GoRoute(
        name: 'onboarding',
        path: '/',
        builder: (context, state) => OnBording()),
    GoRoute(
        name: 'addProperty',
        path: '/addProperty',
        builder: (context, state) => AddProperties()),
    GoRoute(
      name: 'propertyDetail',
      path: '/propertyDetail',
      builder: (context, state) => ListedPropertyDetail(),
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return Home(child: child);
      },
      routes: [
        GoRoute(
          name: 'properties',
          path: '/properties',
          builder: (context, state) => Properties(),
        ),
        GoRoute(
          name: 'request',
          path: '/request',
          builder: (context, state) => const Request(),
        ),
        GoRoute(
          name: 'analytics',
          path: '/analytics',
          builder: (context, state) => const Analytics(),
        ),
        GoRoute(
          name: 'profile',
          path: '/profile',
          builder: (context, state) => const Profile(),
        ),
      ],
    ),
  ],
);
