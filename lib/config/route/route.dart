import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/route/navigator_observer.dart';
import 'package:minapp/features/guest/features/HousType/domain/entities/g_property_entity.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/booking/booking_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/houstype_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/bloc/popular_property/popular_property_bloc.dart';
import 'package:minapp/features/guest/features/HousType/presentation/pages/booking.dart';
import 'package:minapp/features/guest/features/HousType/presentation/pages/house_detail.dart';
import 'package:minapp/features/guest/features/HousType/presentation/pages/house_type.dart';
import 'package:minapp/features/guest/features/HousType/presentation/pages/house_type_detail.dart';
import 'package:minapp/features/guest/features/booked/domain/entities/my_booking_entity.dart';
import 'package:minapp/features/guest/features/booked/presentation/bloc/booked_bloc.dart';
import 'package:minapp/features/guest/features/booked/presentation/pages/booked.dart';
import 'package:minapp/features/guest/features/booked/presentation/pages/booked_detail.dart';
import 'package:minapp/features/guest/features/guestHome/presentation/pages/guest_home.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/total_property_bloc.dart';
import 'package:minapp/features/host/features/analytics/presentation/pages/analytics.dart';
import 'package:minapp/features/auth/presentation/pages/account_setup.dart';
import 'package:minapp/features/auth/presentation/pages/otp_verification.dart';
import 'package:minapp/features/auth/presentation/pages/profile_setup.dart';
import 'package:minapp/features/host/features/home/presentation/pages/home.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/account.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/general_information.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/language.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/profile.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/add_properties.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/listed_property_detail.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/properties.dart';
import 'package:minapp/features/host/features/request/presentation/bloc/request_bloc.dart';
import 'package:minapp/features/host/features/request/presentation/pages/request.dart';
import 'package:minapp/features/onbording/presentation/pages/onbording.dart';
import 'package:minapp/features/onbording/presentation/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/onbording/presentation/bloc/on_bording_bloc.dart';
import '../../service_locator.dart';

Future<GoRouter> createRouter() async {
  final prefs = await SharedPreferences.getInstance();
  bool isFirstTimeUser = prefs.getBool('isFirstTimeUser') ?? true;

  final GoRouter router = GoRouter(
    observers: [MyNavigatorObserver()],
    initialLocation: isFirstTimeUser ? '/onboarding' : '/houseType',
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
        ),
      ),
      GoRoute(
        name: 'addProperty',
        path: '/addProperty',
        builder: (context, state) => AddProperties(),
      ),
      GoRoute(
        name: 'propertyDetail',
        path: '/propertyDetail',
        builder: (context, state) {
          final property = state.extra as PropertyEntity;
          return ListedPropertyDetail(
            propertyEntity: property,
          );
        },
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
              path: 'profileSetup',
              builder: (context, state) => ProfileSetup(),
            ),
          ]),

      // host
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Home(
              navigationShell:
                  navigationShell); // Pass navigationShell for controlling navigation.
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                name: 'properties',
                path: '/properties',
                builder: (context, state) => Properties(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                  name: 'request',
                  path: '/request',
                  builder: (context, state) => BlocProvider(
                        create: (context) =>
                            sl<RequestBloc>()..add(GetReservationEvent()),
                        child: const Request(),
                      )),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                  name: 'analytics',
                  path: '/analytics',
                  builder: (context, state) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => sl<AnalyticsBloc>()
                              ..add(GetOccupancyRateEvent()),
                          ),
                          BlocProvider(
                            create: (context) => sl<TotalPropertyBloc>()
                              ..add(GetTotalPropertyEvent()),
                          ),
                        ],
                        child: const Analytics(),
                      )),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                name: 'profile',
                path: '/profile',
                builder: (context, state) => const Profile(),
                routes: [
                  GoRoute(
                    name: 'generalInformation',
                    path: '/generalInformation',
                    builder: (context, state) => GeneralInformation(),
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
                ],
              ),
            ],
          ),
        ],
      ),
      //Guest routes
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return GuestHome(
              navigationShell:
                  navigationShell); // Pass navigationShell for controlling navigation.
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                  name: 'houseType',
                  path: '/houseType',
                  builder: (context, state) => HouseType(),
                  routes: [
                    GoRoute(
                      name: 'houseTypeDetail',
                      path: '/houseTypeDetail',
                      builder: (context, state) {
                        final name = state.extra as String;
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(
                                create: (context) => sl<HoustypeBloc>()
                                  ..add(
                                    GetPropertyByHouseTypeEvent(name: name),
                                  )),
                            BlocProvider(
                              create: (context) => sl<PopularPropertyBloc>()
                                ..add(GetPopularPropertyEvent()),
                            ),
                          ],
                          child: HouseTypeDetail(
                            name: name,
                          ),
                        );
                      },
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
              GoRoute(
                  name: 'booked',
                  path: '/booked',
                  builder: (context, state) => BlocProvider(
                        create: (context) =>
                            sl<BookedBloc>()..add(GetMyBookingEvent()),
                        child: Booked(),
                      ),
                  routes: [
                    GoRoute(
                      name: 'bookedDetail',
                      path: 'bookedDetail/:token',
                      builder: (context, state) {
                        final property = state.extra as ResultBookingEntity;
                        final token = state.pathParameters['token'];
                        return BookedDetail(property: property, token: token!);
                      },
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(),
            routes: [
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
                        }),
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
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'houseDetail',
        path: '/houseDetail/:token',
        builder: (context, state) {
          final property = state.extra as ResultEntity;
          final token = state.pathParameters['token'];
          return HouseDetail(
            property: property,
            token: token!,
          );
        },
      ),
      GoRoute(
          name: 'booking',
          path: '/booking',
          builder: (context, state) {
            final id = state.extra as int;
            return BlocProvider(
              create: (context) => sl<BookingBloc>(),
              child: Booking(
                id: id,
              ),
            );
          }),
    ],
  );

  return router;
}

CustomTransitionPage<T> createCustomTransition<T>({
  required Widget child,
  LocalKey? key,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation.drive(
          Tween<double>(begin: 0.0, end: 1.0).chain(
            CurveTween(curve: Curves.easeInOut), // Smoother animation
          ),
        ),
        child: child,
      );
    },
  );
}
