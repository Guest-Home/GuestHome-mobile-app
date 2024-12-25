import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/route/navigator_observer.dart';
import 'package:minapp/features/guest/features/HousType/presentation/pages/house_type.dart';
import 'package:minapp/features/guest/features/booked/presentation/pages/booked.dart';
import 'package:minapp/features/guest/features/guestHome/presentation/pages/guest_home.dart';
import 'package:minapp/features/host/features/analytics/presentation/pages/analytics.dart';
import 'package:minapp/features/auth/presentation/pages/account_setup.dart';
import 'package:minapp/features/auth/presentation/pages/otp_verification.dart';
import 'package:minapp/features/auth/presentation/pages/profile_setup.dart';
import 'package:minapp/features/host/features/home/presentation/pages/home.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/account.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/general_information.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/language.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/profile.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/add_properties.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/listed_property_detail.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/properties.dart';
import 'package:minapp/features/host/features/request/presentation/pages/request.dart';
import 'package:minapp/features/onbording/presentation/pages/onbording.dart';

final GoRouter router = GoRouter(
  observers: [MyNavigatorObserver()],
  initialLocation: '/',
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
    GoRoute(
        name: 'accountSetup',
        path: '/accountSetup',
        builder: (context, state) => AccountSetup(),
        routes: [
          GoRoute(
            name: 'otpVerification',
            path: '/otpVerification',
            builder: (context, state) => OtpVerification(),
          ),
          GoRoute(
            name: 'profileSetup',
            path: '/v',
            builder: (context, state) => ProfileSetup(),
          ),
        ]),
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
            routes: [
              GoRoute(
                name: 'generalInformation',
                path: '/generalInformation',
                builder: (context, state) => const GeneralInformation(),
              ),
              GoRoute(
                name: 'language',
                path: '/language',
                builder: (context, state) => const Language(),
              ),
              GoRoute(
                name: 'account',
                path: '/account',
                builder: (context, state) => const Account(),
              ),
            ]),
      ],
    ),
    //Guest routes

    ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return GuestHome(child: child);
        },
        routes: [
          GoRoute(
            name: 'houseType',
            path: '/houseType',
            builder: (context, state) => HouseType(),
          ),
          GoRoute(
            name: 'booked',
            path: '/booked',
            builder: (context, state) => Booked(),
          ),
        ])
  ],
);
