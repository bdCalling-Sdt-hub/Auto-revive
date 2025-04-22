import 'package:autorevive/pregentaitions/screens/auth/customer_signup/customer_signup_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/email_verify/email_verify_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/login/log_in_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_additional_information/mechanic_additional_information.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_experience_skill/mechanic_experience_skill.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_personal_screen/mechanic_personal_information_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_profile_information_screen/mechanic_profile_information_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_reference_screen/mechanic_reference_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_resume_certificate_screen/mechanic_resume_certificate_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/otp/otp_screen.dart';
import 'package:autorevive/pregentaitions/screens/splash_screen/splash_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/basic_info_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/business_requirement_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/company_information_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/licensing_and_ompliance_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/profile_details/profile_details_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/service_coverage_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/auth/vehicle_equipment_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/custom_bottom_nav/tow_truck_bottom_nav_bar.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/tow_truck_bookings/tow_truck_details_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/tow_truck_bookings/tow_trucks_bookings_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/tow_truck_profile/earning/earning_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/tow_truck_profile/earning/withdraw_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/tow_turck_job/tow_truck_job_request_screen.dart';
import 'package:autorevive/pregentaitions/tow_truck_section/screens/tow_turck_job/tow_truck_job_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../pregentaitions/screens/auth/mechanic_view/mechanic_employment_history_screen/mechanic_employment_history_screen.dart';
import '../../../pregentaitions/screens/auth/mechanic_view/mechanic_tools_equipment_screen/mechanic_tools_equipment_screen.dart';
import '../../../pregentaitions/screens/auth/reset_password/reset_password_screen.dart';
import '../../../pregentaitions/screens/auth/role/role_screen.dart';
import '../../../pregentaitions/screens/customer/cusotmer_map/customer_map_screen.dart';
import '../../../pregentaitions/screens/customer/customer_booking/customer_booking_cancel_screen.dart';
import '../../../pregentaitions/screens/customer/customer_booking/customer_booking_details_screen.dart';
import '../../../pregentaitions/screens/customer/customer_bottom_navbar/customer_bottom_nav_bar.dart';
import '../../../pregentaitions/screens/customer/customer_mechanic/customer_mechanic_screen.dart';
import '../../../pregentaitions/screens/customer/customer_selecte_car/customer_selecte_car_screen.dart';
import '../../../pregentaitions/screens/message/chat/chat_screen.dart';
import '../../../pregentaitions/screens/onboarding_screen/onboarding_screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/OnboardingScreen";
  static const String logInScreen = "/LogInScreen";
  static const String emailVerifyScreen = "/EmailVerifyScreen";
  static const String roleScreen = "/SignUpScreen";
  static const String otpScreen = "/OtpScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";
  static const String mechanicPersonalInformationScreen =
      "/MechanicPersonalInformationScreen";
  static const String mechanicExperienceSkillScreen =
      "/MechanicExperienceSkillScreen";
  static const String mechanicToolsEquipmentScreen =
      "/MechanicToolsEquipmentScreen";
  static const String mechanicEmploymentHistoryScreen =
      "/MechanicEmploymentHistoryScreen";
  static const String mechanicReferenceScreen = "/MechanicReferenceScreen";
  static const String mechanicAdditionalInformationScreen =
      "/MechanicAdditionalInformationScreen";
  static const String mechanicResumeCertificateScreen =
      "/MechanicResumeCertificateScreen";
  static const String mechanicProfileInformationScreen =
      "/MechanicProfileInformationScreen";
  static const String customerSignupScreen = "/CustomerSignupScreen";
  static const String customerBottomNavBar = "/CustomerBottomNavBar";
  static const String towTruckBottomNavBar = "/towTruckBottomNavBar";
  static const String basicInfoScreen = "/basicInfoScreen";
  static const String companyInformationScreen = "/companyInformationScreen";
  static const String licensingAndComplianceScreen =
      "/licensingAndComplianceScreen";
  static const String customerMechanicScreen = "/CustomerMechanicScreen";

  static const String vehicleEquipmentScreen = "/vehicleEquipmentScreen";
  static const String serviceCoverageScreen = "/serviceCoverageScreen";
  static const String businessRequirementScreen = "/businessRequirementScreen";
  static const String profileDetailsScreen = "/profileDetailsScreen";

  static const String customerSelectCarScreen = "/CustomerSelectCarScreen";
  static const String customerMapScreen = "/CustomerMapScreen";
  static const String messageChatScreen = "/MessageChatScreen";

  static const String towTruckJobScreen = "/towTruckJobScreen";
  static const String towTruckJobRequestScreen = "/TowTruckJobRequestScreen";
  static const String towTrucksBookingsScreen = "/TowTrucksBookingsScreen";
  static const String towTruckDetailsScreen = "/towTruckDetailsScreen";
  static const String earningScreen = "/EarningScreen";
  static const String withdrawScreen = "/withdrawScreen";
  static const String customerBookingDetailsScreen = "/CustomerBookingDetailsScreen";
  static const String customerBookingCancelScreen = "/CustomerBookingCancelScreen";

  static final GoRouter goRouter =
      GoRouter(initialLocation: splashScreen, routes: [
    GoRoute(
      path: splashScreen,
      name: splashScreen,
      builder: (context, state) {
        return SplashScreen();
      },
      redirect: (context, state) {
        Future.delayed(const Duration(seconds: 3), () async {
          AppRoutes.goRouter.replaceNamed(AppRoutes.onboardingScreen);
        });
      },
    ),

    ///<<<=============>>> ONBOARDING SCREEN <<<===============>>>

    GoRoute(
      path: onboardingScreen,
      name: onboardingScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(const OnboardingScreen(), state),
    ),

    ///<<<=============>>> LOGIN SCREEN <<<===============>>>

    GoRoute(
      path: logInScreen,
      name: logInScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(LogInScreen(), state),
    ),

    ///<<<=============>>> EMAIL VERIFY SCREEN <<<===============>>>
    GoRoute(
      path: emailVerifyScreen,
      name: emailVerifyScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(EmailVerifyScreen(), state),
    ),

    ///<<<=============>>> OTP SCREEN <<<===============>>>

    GoRoute(
      path: otpScreen,
      name: otpScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(OtpScreen(), state),
    ),

    ///<<<=============>>> RESET PASSWORD SCREEN <<<===============>>>

    GoRoute(
      path: resetPasswordScreen,
      name: resetPasswordScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(ResetPasswordScreen(), state),
    ),

    ///<<<=============>>> SIGN UP SCREEN <<<===============>>>

    GoRoute(
      path: roleScreen,
      name: roleScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(RoleScreen(), state),
    ),

    ///<<<=============>>> MECHANIC PERSONAL INFORMATION SCREEN <<<===============>>>

    GoRoute(
      path: mechanicPersonalInformationScreen,
      name: mechanicPersonalInformationScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(MechanicPersonalInformationScreen(), state),
    ),

    ///<<<=============>>> MECHANIC Experience and Skill <<<===============>>>
    GoRoute(
      path: mechanicExperienceSkillScreen,
      name: mechanicExperienceSkillScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(MechanicExperienceSkillScreen(), state),
    ),

    ///<<<=============>>>  MECHANIC TOOLS EQUIPMENT SCREEN <<<===============>>>
    GoRoute(
      path: mechanicToolsEquipmentScreen,
      name: mechanicToolsEquipmentScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(MechanicToolsEquipmentScreen(), state),
    ),

    ///<<<=============>>> MECHANIC EMPLOYMENT HISTORY SCREEN <<<===============>>>
    GoRoute(
      path: mechanicEmploymentHistoryScreen,
      name: mechanicEmploymentHistoryScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(MechanicEmploymentHistoryScreen(), state),
    ),

    ///<<<=============>>> MECHANIC REFERENCE SCREEN <<<===============>>>
    GoRoute(
      path: mechanicReferenceScreen,
      name: mechanicReferenceScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(MechanicReferenceScreen(), state),
    ),

    ///<<<=============>>> MECHANIC Additional Information SCREEN <<<===============>>>
    GoRoute(
      path: mechanicAdditionalInformationScreen,
      name: mechanicAdditionalInformationScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(MechanicAdditionalInformationScreen(), state),
    ),

    ///<<<=============>>> MECHANIC RESUME CERTIFICATE SCREEN <<<===============>>>
    GoRoute(
      path: mechanicResumeCertificateScreen,
      name: mechanicResumeCertificateScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(MechanicResumeCertificateScreen(), state),
    ),

    ///<<<=============>>> MECHANIC PROFILE INFORMATION SCREEN <<<===============>>>
    GoRoute(
      path: mechanicProfileInformationScreen,
      name: mechanicProfileInformationScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(MechanicProfileInformationScreen(), state),
    ),

    ///<<<=============>>> Customer Sign Up SCREEN <<<===============>>>

    GoRoute(
      path: customerSignupScreen,
      name: customerSignupScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(CustomerSignupScreen(), state),
    ),

    ///<<<=============>>> Customer BOTTOM NAV BAR <<<===============>>>

    GoRoute(
      path: customerBottomNavBar,
      name: customerBottomNavBar,
      pageBuilder: (context, state) =>
          _customTransitionPage(CustomerBottomNavBar(), state),
    ),

    ///<<<=============>>> BASIC INFORMATION SCREEN <<<===============>>>

    GoRoute(
      path: basicInfoScreen,
      name: basicInfoScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(BasicInfoScreen(), state),
    ),

    ///<<<=============>>> BASIC INFORMATION SCREEN <<<===============>>>

    GoRoute(
      path: companyInformationScreen,
      name: companyInformationScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(CompanyInformationScreen(), state),
    ),

    ///<<<=============>>> BASIC INFORMATION SCREEN <<<===============>>>

    GoRoute(
      path: licensingAndComplianceScreen,
      name: licensingAndComplianceScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(LicensingAndComplianceScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: customerMechanicScreen,
      name: customerMechanicScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(CustomerMechanicScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: vehicleEquipmentScreen,
      name: vehicleEquipmentScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(VehicleEquipmentScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: serviceCoverageScreen,
      name: serviceCoverageScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(ServiceCoverageScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: businessRequirementScreen,
      name: businessRequirementScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(BusinessRequirementScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: profileDetailsScreen,
      name: profileDetailsScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(ProfileDetailsScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: customerSelectCarScreen,
      name: customerSelectCarScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(CustomerSelectCarScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: customerMapScreen,
      name: customerMapScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(CustomerMapScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: towTruckBottomNavBar,
      name: towTruckBottomNavBar,
      pageBuilder: (context, state) =>
          _customTransitionPage(TowTruckBottomNavBar(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: towTruckJobScreen,
      name: towTruckJobScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(TowTruckJobScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: towTruckJobRequestScreen,
      name: towTruckJobRequestScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(TowTruckJobRequestScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: messageChatScreen,
      name: messageChatScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(MessageChatScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: towTrucksBookingsScreen,
      name: towTrucksBookingsScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(TowTrucksBookingsScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: towTruckDetailsScreen,
      name: towTruckDetailsScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(TowTruckDetailsScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: earningScreen,
      name: earningScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(EarningScreen(), state),
    ),

    ///<<<=============>>> CUSTOMER MECHANIC SCREEN <<<===============>>>

    GoRoute(
      path: withdrawScreen,
      name: withdrawScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(WithdrawScreen(), state),
    ),



        ///<<<=============>>> CUSTOMER BOOKING DETAILS SCREEN <<<===============>>>

        GoRoute(
          path: customerBookingDetailsScreen,
          name: customerBookingDetailsScreen,
          pageBuilder: (context, state) =>
              _customTransitionPage(CustomerBookingDetailsScreen(), state),
        ),


        ///<<<=============>>> CUSTOMER BOOKING Cancel SCREEN <<<===============>>>

        GoRoute(
          path: customerBookingCancelScreen,
          name: customerBookingCancelScreen,
          pageBuilder: (context, state) =>
              _customTransitionPage(CustomerBookingCancelScreen(), state),
        ),
  ]);

  static Page<dynamic> _customTransitionPage(
      Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
