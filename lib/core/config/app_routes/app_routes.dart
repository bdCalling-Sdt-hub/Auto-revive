import 'package:autorevive/pregentaitions/screens/auth/customer_signup/customer_signup_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/email_verify/email_verify_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/login/log_in_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_experience_skill/mechanic_experience_skill.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_personal_screen/mechanic_personal_information_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/otp/otp_screen.dart';
import 'package:autorevive/pregentaitions/screens/splash_screen/splash_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/basic_info_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/company_information_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/licensing_and_ompliance_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/vehicle_equipment_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../pregentaitions/screens/auth/reset_password/reset_password_screen.dart';
import '../../../pregentaitions/screens/auth/role/role_screen.dart';
import '../../../pregentaitions/screens/customer/cusotmer_map/customer_map_screen.dart';
import '../../../pregentaitions/screens/customer/customer_bottom_navbar/customer_bottom_nav_bar.dart';
import '../../../pregentaitions/screens/customer/customer_mechanic/customer_mechanic_screen.dart';
import '../../../pregentaitions/screens/customer/customer_selecte_car/customer_selecte_car_screen.dart';
import '../../../pregentaitions/screens/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String logInScreen = "/LogInScreen";
  static const String emailVerifyScreen = "/EmailVerifyScreen";
  static const String roleScreen = "/SignUpScreen";
  static const String otpScreen = "/OtpScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String mechanicPersonalInformationScreen = "/MechanicPersonalInformationScreen";
  static const String mechanicExperienceSkillScreen = "/MechanicExperienceSkillScreen";
  static const String customerSignupScreen = "/CustomerSignupScreen";
  static const String customerBottomNavBar = "/CustomerBottomNavBar";
  static const String basicInfoScreen = "/basicInfoScreen";
  static const String companyInformationScreen = "/companyInformationScreen";
  static const String licensingAndComplianceScreen = "/licensingAndComplianceScreen";
  static const String customerMechanicScreen = "/CustomerMechanicScreen";

  static const String vehicleEquipmentScreen = "/vehicleEquipmentScreen";

  static const String customerSelectCarScreen = "/CustomerSelectCarScreen";
  static const String customerMapScreen = "/CustomerMapScreen";


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

      ///<<<=============>>> SIGN UP SCREEN <<<===============>>>

      GoRoute(
        path: roleScreen,
        name: roleScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(RoleScreen(), state),
      ),

      ///<<<=============>>> MECHANIC PERSONAL INFORMATION SCREEN <<<===============>>>

      GoRoute(
        path: mechanicPersonalInformationScreen,
        name: mechanicPersonalInformationScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(MechanicPersonalInformationScreen(), state),
      ),
        ///<<<=============>>> MECHANIC Experience and Skill <<<===============>>>
      GoRoute(
        path: mechanicExperienceSkillScreen,
        name: mechanicExperienceSkillScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(MechanicExperienceSkillScreen(), state),
      ),

      ///<<<=============>>> Customer Sign Up SCREEN <<<===============>>>

      GoRoute(
        path: customerSignupScreen,
        name: customerSignupScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(CustomerSignupScreen(), state),
      ),



      ///<<<=============>>> Customer BOTTOM NAV BAR <<<===============>>>

      GoRoute(
        path: customerBottomNavBar,
        name: customerBottomNavBar,
        pageBuilder: (context, state) =>  _customTransitionPage(CustomerBottomNavBar(), state),
      ),

      ///<<<=============>>> BASIC INFORMATION SCREEN <<<===============>>>

      GoRoute(
        path: basicInfoScreen,
        name: basicInfoScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(BasicInfoScreen(), state),
      ),

      ///<<<=============>>> BASIC INFORMATION SCREEN <<<===============>>>

      GoRoute(
        path: companyInformationScreen,
        name: companyInformationScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(CompanyInformationScreen(), state),
      ),

 ///<<<=============>>> BASIC INFORMATION SCREEN <<<===============>>>

      GoRoute(
        path: licensingAndComplianceScreen,
        name: licensingAndComplianceScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(LicensingAndComplianceScreen(), state),
      ),



      ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

      GoRoute(
        path: customerMechanicScreen,
        name: customerMechanicScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(CustomerMechanicScreen(), state),
      ),


      ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

      GoRoute(
        path: vehicleEquipmentScreen,
        name: vehicleEquipmentScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(VehicleEquipmentScreen(), state),
      ),




      ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

      GoRoute(
        path: customerSelectCarScreen,
        name: customerSelectCarScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(CustomerSelectCarScreen(), state),
      ),



      ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

      GoRoute(
        path: customerMapScreen,
        name: customerMapScreen,
        pageBuilder: (context, state) =>  _customTransitionPage(CustomerMapScreen(), state),
      ),



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