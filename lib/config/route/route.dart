import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/route/navigator_observer.dart';
import 'package:minapp/features/guest/features/HousType/presentation/pages/booking.dart';
import 'package:minapp/features/guest/features/HousType/presentation/pages/house_detail.dart';
import 'package:minapp/features/guest/features/HousType/presentation/pages/house_type.dart';
import 'package:minapp/features/guest/features/HousType/presentation/pages/house_type_detail.dart';
import 'package:minapp/features/guest/features/booked/presentation/pages/booked.dart';
import 'package:minapp/features/guest/features/booked/presentation/pages/booked_detail.dart';
import 'package:minapp/features/guest/features/guestHome/presentation/pages/guest_home.dart';
import 'package:minapp/features/host/features/analytics/presentation/pages/analytics.dart';
import 'package:minapp/features/auth/presentation/pages/account_setup.dart';
import 'package:minapp/features/auth/presentation/pages/otp_verification.dart';
import 'package:minapp/features/auth/presentation/pages/profile_setup.dart';
import 'package:minapp/features/host/features/home/presentation/pages/home.dart';
import 'package:minapp/features/host/features/profile/domain/entities/user_profile_entity.dart';
import 'package:minapp/features/host/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/account.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/general_information.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/language.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/profile.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/add_properties.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/listed_property_detail.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/properties.dart';
import 'package:minapp/features/host/features/request/presentation/pages/request.dart';
import 'package:minapp/features/onbording/presentation/pages/onbording.dart';
import 'package:minapp/features/onbording/presentation/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import '../../features/host/features/properties/presentation/bloc/properties_bloc.dart';
import '../../features/onbording/presentation/bloc/on_bording_bloc.dart';
import '../../service_locator.dart';

Future<GoRouter> createRouter() async {
  final prefs = await SharedPreferences.getInstance();
  bool isFirstTimeUser = prefs.getBool('isFirstTimeUser') ?? true;

  final GoRouter router = GoRouter(
    observers: [MyNavigatorObserver()],
   initialLocation: isFirstTimeUser ? '/onboarding' : '/properties',

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text("page not found"),
      ),
    ),
    redirect: (context, state) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn =
          prefs.getBool('isLogin') ?? false; // Check if the token exists
      // Check if the current route is '/accountSetup' or starts with '/accountSetup/'
      bool isAccountSetupRoute =
          state.uri.toString().startsWith('/accountSetup');
      bool isOnbordingRoute = state.uri.toString().startsWith('/onboarding');

      // If the user is not logged in and trying to access a protected route
      if (!isLoggedIn && !isAccountSetupRoute && !isOnbordingRoute) {
        return '/accountSetup'; // Redirect to the login page
      }

      return null; // No redirect
    },
    routes: [
      GoRoute(
          name: 'splash',
          path: '/splash',
          builder: (context, state) => Splash()),
      GoRoute(
          name: 'onboarding',
          path: '/onboarding',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<OnBordingBloc>(),
            child: OnBording(),
          ), ),
      GoRoute(
          name: 'addProperty',
          path: '/addProperty',
          builder: (context, state) => BlocProvider(create: (context) => sl<AddPropertyBloc>(),
          child:AddProperties() ,
          ),
          ),
      GoRoute(
        name: 'propertyDetail',
        path: '/propertyDetail',
        builder: (context, state){
          final property= state.extra as PropertyEntity;
         return ListedPropertyDetail(propertyEntity: property,);
        },
      ),
      GoRoute(
          name: 'accountSetup',
          path: '/accountSetup',
          builder: (context, state) => AccountSetup(),

          routes: [
            GoRoute(
              name: 'otpVerification',
              path: 'otpVerification',
              builder: (context, state) => OtpVerification(),
            ),
            GoRoute(
              name: 'profileSetup',
              path: 'profileSetup',
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
            builder: (context, state) => BlocProvider(
              create: (context) => sl<PropertiesBloc>()..add(GetPropertiesEvent()),
              child:Properties(),
            ),
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
            builder: (context, state) =>const Profile(),

            routes: [
              GoRoute(
                name: 'generalInformation',
                path: '/generalInformation',
                builder: (context, state){

                  return GeneralInformation();
  }
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
            ]
          ),
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
                routes: [
                  GoRoute(
                    name: 'houseTypeDetail',
                    path: '/houseTypeDetail',
                    builder: (context, state) => HouseTypeDetail(),
                  ),
                ]),
            GoRoute(
                name: 'booked',
                path: '/booked',
                builder: (context, state) => Booked(),
                routes: [
                  GoRoute(
                    name: 'bookedDetail',
                    path: '/bookedDetail',
                    builder: (context, state) => BookedDetail(),
                  ),
                ]),
            GoRoute(
                name: 'guestProfile',
                path: '/guestProfile',
                builder: (context, state) => const Profile(),
                routes: [
                  GoRoute(
                    name: 'guestGeneralInformation',
                    path: '/guestGeneralInformation',
                    builder: (context, state) {
                      return GeneralInformation();
                    }
                  ),
                  GoRoute(
                    name: 'guestLanguage',
                    path: '/guestLanguage',
                    builder: (context, state) => const Language(),
                  ),
                  GoRoute(
                    name: 'guestAccount',
                    path: '/guestAccount',
                    builder: (context, state) => const Account(),
                  ),
                ]),
          ]),
      GoRoute(
          name: 'houseDetail',
          path: '/houseDetail',
          builder: (context, state) => HouseDetail(),
          routes: [
            GoRoute(
              name: 'booking',
              path: '/booking',
              builder: (context, state) => Booking(),
            ),
          ]),
    ],
  );
  return router;
}
