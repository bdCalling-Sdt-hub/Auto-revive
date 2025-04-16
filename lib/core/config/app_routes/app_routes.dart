import 'package:autorevive/pregentaitions/screens/auth/login/log_in_screen.dart';
import 'package:autorevive/pregentaitions/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../pregentaitions/screens/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String logInScreen = "/LogInScreen";

  static final GoRouter goRouter = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
          path: splashScreen,
          name: splashScreen,
          builder: (context, state) {
           return SplashScreen();
          },
        redirect: (context, state) {
          Future.delayed(const Duration(seconds: 3), ()async{
             AppRoutes.goRouter.replaceNamed(AppRoutes.onboardingScreen);
          });
        },
      ),


      GoRoute(
        path: onboardingScreen,
        name: onboardingScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(const OnboardingScreen(), state),
      ),



      GoRoute(
        path: logInScreen,
        name: logInScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(LogInScreen(), state),
      )

    ]
  );



  static Page<dynamic> _customTransitionPage(Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

}