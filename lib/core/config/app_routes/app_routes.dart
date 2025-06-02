import 'package:autorevive/core/app_constants/app_constants.dart';
import 'package:autorevive/helpers/prefs_helper.dart';
import 'package:autorevive/pregentaitions/screens/auth/change_password/change_password.dart';
import 'package:autorevive/pregentaitions/screens/auth/customer_signup/customer_signup_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/email_verify/email_verify_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/login/log_in_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_signup/mechanic_signup_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_additional_information/mechanic_additional_information.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_experience_skill/mechanic_experience_skill.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_personal_screen/mechanic_personal_information_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_profile_information_screen/mechanic_profile_information_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_reference_screen/mechanic_reference_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_resume_certificate_screen/mechanic_resume_certificate_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/otp/otp_screen.dart';
import 'package:autorevive/pregentaitions/screens/auth/tow_track_signup/towtrack_signup_screen.dart';
import 'package:autorevive/pregentaitions/screens/splash_screen/splash_screen.dart';
import 'package:autorevive/pregentaitions/screens/tow_truck_profile/admin_support/admin_support_screen.dart';
import 'package:autorevive/services/socket_services.dart';
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
import '../../../pregentaitions/screens/mechanic/mechanic_booking_on_site/mechanic_bookings_screen/mechanic_bookings_details_screen.dart';
import '../../../pregentaitions/screens/mechanic/mechanic_booking_on_site/mechanic_bookings_screen/mechanic_bookings_screen.dart';
import '../../../pregentaitions/screens/mechanic/mechanic_booking_on_site/mechanic_bookings_screen/mechanic_complete_screen.dart';
import '../../../pregentaitions/screens/mechanic/mechanic_booking_on_site/mechanic_bookings_screen/mechanic_map_screen.dart';
import '../../../pregentaitions/screens/mechanic/mechanic_bottom_nav/mechanic_bottom_nav.dart';
import '../../../pregentaitions/screens/mechanic/mechanic_job_screen/mechanic_job_request_screen.dart';
import '../../../pregentaitions/screens/mechanic/mechanic_job_screen/mechanic_job_screen.dart';
import '../../../pregentaitions/screens/message/chat/chat_screen.dart';
import '../../../pregentaitions/screens/notifications_screen/notifications_screen.dart';
import '../../../pregentaitions/screens/onboarding_screen/onboarding_screen.dart';
import '../../../pregentaitions/screens/settings_screen/privacy_policy_allscreen.dart';
import '../../../pregentaitions/screens/progress/progress_screen.dart';
import '../../../pregentaitions/screens/settings_screen/settings_screen.dart';
import '../../../pregentaitions/screens/tow_truck_profile/earning/add_balace_screen.dart';
import '../../../pregentaitions/screens/tow_truck_profile/earning/earning_screen.dart';
import '../../../pregentaitions/screens/tow_truck_profile/earning/payment_web_view.dart';
import '../../../pregentaitions/screens/tow_truck_profile/earning/withdraw_screen.dart';
import '../../../pregentaitions/screens/tow_truck_profile/personal_info_customer/personal_info_customer_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/auth/tow_track_basic_info_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/auth/business_requirement_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/auth/company_information_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/auth/licensing_and_ompliance_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/auth/profile_details/profile_details_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/auth/service_coverage_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/auth/vehicle_equipment_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/custom_bottom_nav/tow_truck_bottom_nav_bar.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/tow_truck_bookings/tow_truck_details_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/tow_truck_bookings/tow_trucks_bookings_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/tow_turck_job/tow_truck_job_request_screen.dart';
import '../../../pregentaitions/screens/tow_truck_section/screens/tow_turck_job/tow_truck_job_screen.dart';
import '../../../services/firebase_notification_services.dart';

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
  static const String mechanicToolsEquipmentScreen = "/MechanicToolsEquipmentScreen";
  static const String mechanicEmploymentHistoryScreen = "/MechanicEmploymentHistoryScreen";
  static const String mechanicReferenceScreen = "/MechanicReferenceScreen";
  static const String mechanicAdditionalInformationScreen = "/MechanicAdditionalInformationScreen";
  static const String mechanicResumeCertificateScreen = "/MechanicResumeCertificateScreen";
  static const String mechanicProfileInformationScreen = "/MechanicProfileInformationScreen";
  static const String mechanicJobScreen = "/MechanicJobScreen";
  static const String mechanicBottomNavBar = "/MechanicBottomNavBar";
  static const String mechanicJobRequestScreen = "/MechanicJobRequestScreen";
  static const String mechanicBookingsScreen = "/MechanicBookingsScreen";
  static const String mechanicBookingsDetailsScreen = "/MechanicBookingsDetailsScreen";
  static const String mechanicCompleteDetailsScreen = "/MechanicCompleteDetailsScreen";
  static const String mechanicMapScreen = "/MechanicMapScreen";
  static const String mechanicSignupScreen = "/MechanicSignupScreen";
  static const String towTrackSignupScreen = "/TowTrackSignupScreen";
  static const String notificationsScreen = "/NotificationsScreen";
  static const String settingsScreen = "/SettingsScreen";
  static const String changePasswordScreen = "/ChangePasswordScreen";
  static const String privacyAllScreen = "/PrivacyAllScreen";
  static const String termsConditionsScreen = "/TermsConditionsScreen";
  static const String customerSignupScreen = "/CustomerSignupScreen";
  static const String customerBottomNavBar = "/CustomerBottomNavBar";
  static const String towTruckBottomNavBar = "/towTruckBottomNavBar";
  static const String towTrackBasicInfoScreen = "/towTrackBasicInfoScreen";
  static const String companyInformationScreen = "/companyInformationScreen";
  static const String licensingAndComplianceScreen = "/licensingAndComplianceScreen";
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
  static const String personalInfoCustomerScreen = "/PersonalInfoCustomerScreen";
  static const String progressScreen = "/ProgressScreen";
  static const String adminSupportScreen = "/AdminSupportScreen";
  static const String addBalanceScreen = "/AddBalanceScreen";
  static const String paymentWebView = "/PaymentWebView";




  static final GoRouter goRouter =
      GoRouter(initialLocation: splashScreen, routes: [
    GoRoute(
      path: splashScreen,
      name: splashScreen,
      builder: (context, state) => const SplashScreen(),
      redirect: (context, state) {
        Future.delayed(const Duration(seconds: 3), () async {
          var role = await PrefsHelper.getString(AppConstants.role);
          var token = await PrefsHelper.getString(AppConstants.bearerToken);
          var userId = await PrefsHelper.getString(AppConstants.userId);
          var fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);
          bool isLogged = await PrefsHelper.getBool(AppConstants.isLogged);



          print("======================================$isLogged  \n token: $token \n userId : $userId \n fcm token : $fcmToken");

          SocketServices sockService = SocketServices();

          sockService.init(userId: userId, fcmToken: fcmToken.toString());
          FirebaseNotificationService.listenMessage();

          if(token != "" && isLogged){

            /// ===============Role Check =============>>>
            if(role.toLowerCase() == "customer"){
              AppRoutes.goRouter.replaceNamed(AppRoutes.customerBottomNavBar);
            }else if(role.toLowerCase() == "mechanic"){
              AppRoutes.goRouter.replaceNamed(AppRoutes.mechanicBottomNavBar);
            }else{
              AppRoutes.goRouter.replaceNamed(AppRoutes.towTruckBottomNavBar);
            }
          }else{
            AppRoutes.goRouter.replaceNamed(AppRoutes.onboardingScreen);
          }



        });

        return;
      },
    ),

    ///<<<=============>>> ONBOARDING SCREEN <<<===============>>>

    GoRoute(
      path: onboardingScreen,
      name: onboardingScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(const OnboardingScreen(), state),
    ),

        ///<<<=============>>> ADMIN SUPPORT SCREEN <<<===============>>>

        GoRoute(
          path: adminSupportScreen,
          name: adminSupportScreen,
          pageBuilder: (context, state) =>
              _customTransitionPage(const AdminSupportScreen(), state),
        ),



        ///<<<=============>>> LOGIN SCREEN <<<===============>>>

    GoRoute(
      path: logInScreen,
      name: logInScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(LogInScreen(), state),
    ),


        ///<<<=============>>> CHANGE PASSWORD  SCREEN <<<===============>>>

        GoRoute(
          path: changePasswordScreen,
          name: changePasswordScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(ChangePasswordScreen(), state),
        ),

        ///<<<=============>>> EMAIL VERIFY SCREEN <<<===============>>>
    GoRoute(
      path: emailVerifyScreen,
      name: emailVerifyScreen,
      builder: (context, state) {
        String email = state.extra as String;
        return EmailVerifyScreen(email: email);
      },
      // pageBuilder: (context, state) =>
      //     _customTransitionPage(EmailVerifyScreen(), state),
    ),

    ///<<<=============>>> OTP SCREEN <<<===============>>>

    GoRoute(
      path: otpScreen,
      name: otpScreen,
      builder: (context, state) {
        // String screenType = state.extra as String;
        // String email = state.extra as String;

        final extra = state.extra as Map<String, String>;
        final screenType = extra['screenType'] ?? '';
        final email = extra['email'] ?? '';
        return OtpScreen(screenType: screenType,email: email,);
      },

      // =>
      //     _customTransitionPage(OtpScreen(), state),


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

        ///<<<=============>>> MECHANIC BOTTOM NAVBAR SCREEN <<<===============>>>
        GoRoute(
          path: mechanicBottomNavBar,
          name: mechanicBottomNavBar,
          pageBuilder: (context, state) =>  _customTransitionPage(MechanicBottomNavBar(), state),
        ),

        ///<<<=============>>> MECHANIC JOB SCREEN <<<===============>>>
        GoRoute(
          path: mechanicJobScreen,
          name: mechanicJobScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(MechanicJobScreen(), state),
        ),


        ///<<<=============>>> MECHANIC JOB REQUEST SCREEN <<<===============>>>
        GoRoute(
          path: mechanicJobRequestScreen,
          name: mechanicJobRequestScreen,
          pageBuilder: (context, state) {
            final radius = state.extra as String;
            return MaterialPage(
              child: MechanicJobRequestScreen(radius: radius),
            );
          },
        ),

        ///<<<=============>>> MECHANIC BOOKINGS SCREEN <<<===============>>>
        GoRoute(
          path: mechanicBookingsScreen,
          name: mechanicBookingsScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(MechanicBookingsScreen(), state),
        ),

        ///<<<=============>>> MECHANIC BOOKINGS DETAILS SCREEN <<<===============>>>
        GoRoute(
          path: mechanicBookingsDetailsScreen,
          name: mechanicBookingsDetailsScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(MechanicBookingsDetailsScreen(), state),
        ),


        ///<<<=============>>> MECHANIC COMPLETE DETAILS SCREEN <<<===============>>>
        GoRoute(
          path: mechanicCompleteDetailsScreen,
          name: mechanicCompleteDetailsScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(MechanicCompleteDetailsScreen(), state),
        ),

        ///<<<=============>>> MECHANIC MAP SCREEN <<<===============>>>
        GoRoute(
          path: mechanicMapScreen,
          name: mechanicMapScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(MechanicMapScreen(), state),
        ),

        ///<<<=============>>> MECHANIC SIGN UP SCREEN <<<===============>>>
        GoRoute(
          path: mechanicSignupScreen,
          name: mechanicSignupScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(MechanicSignupScreen(), state),
        ),

        ///<<<=============>>> MECHANIC SIGN UP SCREEN <<<===============>>>
        GoRoute(
          path: towTrackSignupScreen,
          name: towTrackSignupScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(TowTrackSignupScreen(), state),
        ),



        ///=========Privacy All Screen========>>

        GoRoute(
          path: privacyAllScreen,
          name: privacyAllScreen,
          builder: (context, state) {
            return PrivacyAllScreen();
          },
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
      path: towTrackBasicInfoScreen,
      name: towTrackBasicInfoScreen,
      pageBuilder: (context, state) =>
          _customTransitionPage(TowTrackBasicInfoScreen(), state),
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
      pageBuilder: (context, state) {
        final radius = state.extra as String;
        return MaterialPage(
          child: TowTruckJobRequestScreen(radius: radius),
        );
      },
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
        ///<<<=============>>> SETTINGS SCREEN <<<===============>>>


        GoRoute(
          path: settingsScreen,
          name: settingsScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(SettingScreen(), state),
        ),


        ///<<<=============>>> CUSTOMER BOOKING DETAILS SCREEN <<<===============>>>

        GoRoute(
          path: customerBookingDetailsScreen,
          name: customerBookingDetailsScreen,
          pageBuilder: (context, state) =>
              _customTransitionPage(CustomerBookingDetailsScreen(), state),
        ),

        ///<<<=============>>> NOTIFICATIONS SCREEN <<<===============>>>

        GoRoute(
          path: notificationsScreen,
          name: notificationsScreen,
          pageBuilder: (context, state) =>  _customTransitionPage(NotificationScreen(), state),
        ),

        ///<<<=============>>> CUSTOMER BOOKING Cancel SCREEN <<<===============>>>

        GoRoute(
          path: customerBookingCancelScreen,
          name: customerBookingCancelScreen,
          pageBuilder: (context, state) =>
              _customTransitionPage(CustomerBookingCancelScreen(), state),
        ),



        ///<<<=============>>> PROFILE PERSONAL INFORMATION SCREEN <<<===============>>>

        GoRoute(
          path: personalInfoCustomerScreen,
          name: personalInfoCustomerScreen,
          pageBuilder: (context, state) {
            // final isEditable = state.extra as bool? ?? false;
            return _customTransitionPage(PersonalInfoCustomerScreen(), state,
            );
          },
        ),


        ///<<<=============>>> PROFILE PERSONAL INFORMATION SCREEN <<<===============>>>

        GoRoute(
          path: progressScreen,
          name: progressScreen,
          pageBuilder: (context, state) {
            return _customTransitionPage(
              ProgressScreen(),
              state,
            );
          },
        ),


        ///<<<=============>>> ADD BALANCE SCREEN <<<===============>>>

        GoRoute(
          path: addBalanceScreen,
          name: addBalanceScreen,
          pageBuilder: (context, state) {
            return _customTransitionPage(
              AddBalanceScreen(),
              state,
            );
          },
        ),


        ///<<<=============>>> ADD BALANCE SCREEN <<<===============>>>

        GoRoute(
          path: paymentWebView,
          name: paymentWebView,
          pageBuilder: (context, state) {
            final paymentUrl = state.extra as String;
            return MaterialPage(
              child: PaymentWebView(paymentUrl: paymentUrl),
            );
          },
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
