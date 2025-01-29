import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minapp/config/route/navigator_observer.dart';
import 'package:minapp/features/auth/presentation/pages/sign_in.dart';
import 'package:minapp/features/auth/presentation/pages/sign_in_with_tg.dart';
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
import 'package:minapp/features/guest/features/booked/presentation/bloc/booked_detail/booked_detail_bloc.dart';
import 'package:minapp/features/guest/features/booked/presentation/pages/booked.dart';
import 'package:minapp/features/guest/features/booked/presentation/pages/booked_detail.dart';
import 'package:minapp/features/guest/features/booked/presentation/pages/booking_detail_non_approved.dart';
import 'package:minapp/features/guest/features/guestHome/presentation/pages/guest_home.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:minapp/features/host/features/analytics/presentation/bloc/total_property_bloc.dart';
import 'package:minapp/features/host/features/analytics/presentation/pages/analytics.dart';
import 'package:minapp/features/auth/presentation/pages/account_setup.dart';
import 'package:minapp/features/auth/presentation/pages/otp_verification.dart';
import 'package:minapp/features/auth/presentation/pages/profile_setup.dart';
import 'package:minapp/features/host/features/home/presentation/pages/home.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/account.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/delete_account.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/general_information.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/language.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/profile.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/verify_new_phone.dart';
import 'package:minapp/features/host/features/profile/presentation/pages/verify_old_phone.dart';
import 'package:minapp/features/host/features/properties/domain/entities/property_entity.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/add_properties.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/listed_property_detail.dart';
import 'package:minapp/features/host/features/properties/presentation/pages/properties.dart';
import 'package:minapp/features/search/presentation/bloc/search_bloc.dart';
import 'package:minapp/features/search/presentation/pages/search.dart';
import 'package:minapp/features/host/features/request/presentation/bloc/request_bloc.dart';
import 'package:minapp/features/host/features/request/presentation/pages/request.dart';
import 'package:minapp/features/onbording/presentation/pages/onbording.dart';
import 'package:minapp/features/onbording/presentation/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/pages/tg_otp_verification.dart';
import '../../features/host/features/properties/presentation/bloc/add_property/add_property_bloc.dart';
import '../../features/onbording/presentation/bloc/on_bording_bloc.dart';
import '../../main.dart';
import '../../service_locator.dart';

Future<GoRouter> createRouter() async {
  final prefs = await SharedPreferences.getInstance();
  bool isFirstTimeUser = prefs.getBool('isFirstTimeUser') ?? true;
  final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
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

      bool isSinInRoute = state.uri.toString().startsWith('/signIn');
      bool isOnbordingRoute = state.uri.toString().startsWith('/onboarding');

      // If the user is not logged in and trying to access a protected route
      if (!isLoggedIn && !isSinInRoute && !isOnbordingRoute) {
        return '/signIn'; // Redirect to the login page
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
        builder: (context, state) => BlocProvider(
  create: (context) =>sl<AddPropertyBloc>()..add(ResetEvent()),
  child: AddProperties(),
),
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
          name: 'signIn',
          path: '/signIn',
          builder: (context, state) => SignIn(),
          routes: [
            GoRoute(
              name: 'accountSetup',
              path: 'accountSetup',
              builder: (context, state) => AccountSetup(),
            ),
            GoRoute(
              name: 'signInWithTg',
              path: 'signInWithTg',
              builder: (context, state) => SignInWithTg(),
            ),
            GoRoute(
              name: 'otpVerification',
              path: 'otpVerification',
              builder: (context, state) => OtpVerification(),
            ),
            GoRoute(
              name: 'tgOtpVerification',
              path: 'tgOtpVerification',
              builder: (context, state) => TgOtpVerification(),
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
                  routes: [
                    GoRoute(
                      name: 'hostSearch',
                      path: '/hostSearch',
                      builder: (context, state) {
                        return BlocProvider(
                          create: (context) => sl<SearchBloc>(),
                          child: Search(),
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
                      routes: [
                        GoRoute(
                            name: 'verifyOldPhone',
                            path: '/verifyOldPhone',
                            builder: (context, state) {
                              return VerifyOldPhone();
                            }),
                        GoRoute(
                            name: 'verifyNewPhone',
                            path: '/verifyNewPhone',
                            builder: (context, state) {
                              return VerifyNewPhone();
                            }),
                      ]),
                  GoRoute(
                    name: 'language',
                    path: '/language',
                    builder: (context, state) => const Language(),
                  ),
                  GoRoute(
                      name: 'account',
                      path: '/account',
                      builder: (context, state) => const Account(),
                      routes: [
                        GoRoute(
                          name: 'deleteAccount',
                          path: '/deleteAccount',
                          builder: (context, state) => const DeleteAccount(),
                        ),
                      ]),
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
                        routes: [
                          GoRoute(
                            name: 'search',
                            path: '/search',
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => sl<SearchBloc>(),
                                child: Search(),
                              );
                            },
                          ),
                        ]),
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
                        final id = state.extra as int;
                        final token = state.pathParameters['token'];
                        return BlocProvider(
                          create: (context) => sl<BookedDetailBloc>(),
                          child: BookedDetail(
                            token: token!,
                            id: id,
                          ),
                        );
                      },
                    ),
                    GoRoute(
                      name: 'bookedDetailNonApproved',
                      path: 'bookedDetailNonApproved/:token',
                      builder: (context, state) {
                        final property = state.extra as ResultBookingEntity;
                        final token = state.pathParameters['token'];
                        return BookingDetailNonApproved(
                          token: token!,
                          property: property,
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
                  name: 'guestProfile',
                  path: '/guestProfile',
                  builder: (context, state) => const Profile(),
                  routes: [
                    GoRoute(
                        name: 'guestGeneralInformation',
                        path: '/guestGeneralInformation',
                        builder: (context, state) {
                          return GeneralInformation();
                        },
                        routes: [
                          GoRoute(
                              name: 'guestVerifyOldPhone',
                              path: '/guestVerifyOldPhone',
                              builder: (context, state) {
                                return VerifyOldPhone();
                              }),
                          GoRoute(
                              name: 'guestVerifyNewPhone',
                              path: '/guestVerifyNewPhone',
                              builder: (context, state) {
                                return VerifyNewPhone();
                              }),
                        ]),
                    GoRoute(
                      name: 'guestLanguage',
                      path: '/guestLanguage',
                      builder: (context, state) => const Language(),
                    ),
                    GoRoute(
                        name: 'guestAccount',
                        path: '/guestAccount',
                        builder: (context, state) => const Account(),
                        routes: [
                          GoRoute(
                            name: 'guestDeleteAccount',
                            path: '/guestDeleteAccount',
                            builder: (context, state) => const DeleteAccount(),
                          ),
                        ]),
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
