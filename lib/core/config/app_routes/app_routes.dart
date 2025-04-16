import 'package:autorevive/pregentaitions/screens/auth/email_verify/email_verify_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/login/log_in_screen.dart';
import 'package:autorevive/pregentaitions/screens/signup/signup_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/otp/otp_screen.dart';
import 'package:autorevive/pregentaitions/screens/reset_password/reset_password_screen.dart';
import 'package:autorevive/pregentaitions/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../pregentaitions/screens/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String logInScreen = "/LogInScreen";
  static const String emailVerifyScreen = "/EmailVerifyScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String otpScreen = "/OtpScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";

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

      ///<<<=============>>> ONBOARDING SCREEN <<<===============>>>

      GoRoute(
        path: onboardingScreen,
        name: onboardingScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(const OnboardingScreen(), state),
      ),


      ///<<<=============>>> LOGIN SCREEN <<<===============>>>

      GoRoute(
        path: logInScreen,
        name: logInScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(LogInScreen(), state),
      ),



      ///<<<=============>>> EMAIL VERIFY SCREEN <<<===============>>>
      GoRoute(
        path: emailVerifyScreen,
        name: emailVerifyScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(EmailVerifyScreen(), state),
      ),


      ///<<<=============>>> OTP SCREEN <<<===============>>>

      GoRoute(
        path: otpScreen,
        name: otpScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(OtpScreen(), state),
      ),



      ///<<<=============>>> RESET PASSWORD SCREEN <<<===============>>>


      GoRoute(
        path: resetPasswordScreen,
        name: resetPasswordScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(ResetPasswordScreen(), state),
      ),


      ),


      GoRoute(
        path: signUpScreen,
        name: signUpScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(SignUpScreen(), state),
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