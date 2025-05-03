import 'dart:async';
import 'dart:convert';
import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../core/app_constants/app_constants.dart';
import '../core/constants/app_colors.dart';
import '../global/custom_assets/assets.gen.dart';
import '../helpers/prefs_helper.dart';
import '../helpers/toast_message_helper.dart';
import '../pregentaitions/widgets/custom_button.dart';
import '../pregentaitions/widgets/custom_text.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';



class AuthController extends GetxController {


  RxBool signUpLoading = false.obs;

  ///========================================== Sing up ==================================<>
  handleSignUp({String? name, email, phone, password,confirmPassword,filePath}) async {
    String role = await PrefsHelper.getString(AppConstants.role);
    signUpLoading(true);
    var body = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "confirmPassword": confirmPassword,
      "filePath": filePath,
      "role": "customer",
    };

    var response = await ApiClient.postData(ApiConstants.signUpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(AppConstants.bearerToken, response.body["data"]["verificationToken"]);
      if(role == "user"){
        // context.pushNamed(AppRoutes.otpScreen, extra: "mechanic");
      }else{
        // context.pushNamed(AppRoutes.otpScreen, extra: "track");
      }

      ToastMessageHelper.showToastMessage("Account create successful.\n \nNow you have an one time code your email");
      signUpLoading(false);
    } else if(response.statusCode == 1){
      signUpLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      signUpLoading(false);
    }
  }




  RxBool mechanicSignUpLoading = false.obs;

  ///========================================== Mechanic Sing up ==================================<>

  mechanicHandleSignUp({String? name, email, password,confirmPassword,required BuildContext context}) async {
    String role = await PrefsHelper.getString(AppConstants.role);
    mechanicSignUpLoading(true);
    var body = {
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "role": "mechanic",
    };

    var response = await ApiClient.postData(ApiConstants.signUpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(AppConstants.bearerToken, response.body["data"]["verificationToken"]);
      if(role == "mechanic"){
        context.pushNamed(AppRoutes.otpScreen, extra: "mechanic");
      }else{
        // context.pushNamed(AppRoutes.otpScreen, extra: "track");
      }

      ToastMessageHelper.showToastMessage("Account create successful.\n \nNow you have an one time code your email");
      mechanicSignUpLoading(false);
    } else if(response.statusCode == 1){
      mechanicSignUpLoading(false);
      ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    } else {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      mechanicSignUpLoading(false);
    }
  }





  // ///************************************************************************///

  ///===============Verify Email================<>
  RxBool verfyLoading = false.obs;

  verfyEmail(String otpCode, {String screenType = '', required BuildContext context}) async {
    verfyLoading(true);
    var role = await PrefsHelper.getString(AppConstants.role);
    var body = {"otp": otpCode};
    var response = await ApiClient.postData(
        ApiConstants.verifyEmailEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("==========bearer token save done : ${response.body["data"]['accessToken']}");
      await PrefsHelper.setString(AppConstants.bearerToken, response.body["data"]['accessToken']);
      await PrefsHelper.setString(AppConstants.name, response.body["data"]['name']);
      await PrefsHelper.setString(AppConstants.email, response.body["data"]['email']);
      await PrefsHelper.setString(AppConstants.phone, response.body["data"]['phone']);
      if (screenType == 'Sign Up') {

        if(role == "mechanic"){
          _dialog(context, "mechanic");
          // context.go(AppRoutes.loginScreen);
        }else{
          _dialog(context, "track");
          // context.go(AppRoutes.loginScreen);
        }
      }

      // else if(screenType == "user"){
      //   _dialog(context, "user");
      // }else if(screenType == "manager"){
      //   _dialog(context, "manager");
      // } else {
      //   // context.go(AppRoutes.setPasswordScreen);
      // }

      verfyLoading(false);
    } else if(response.statusCode == 1){
      verfyLoading(false);
      // ToastMessageHelper.showToastMessage("Server error! \n Please try later");
    }
    ToastMessageHelper.showToastMessage("${response.body["message"]}");
    verfyLoading(false);

  }

  //
  //
  //
  //
  // ///************************************************************************///
  // ///===============Log in================<>
  // RxBool logInLoading = false.obs;
  // handleLogIn(String email, String password, {required BuildContext context}) async {
  //   logInLoading.value = true;
  //   var fcmToken = await FirebaseNotificationService.getFCMToken();
  //   var role = await PrefsHelper.getString(AppConstants.role);
  //   var headers = {'Content-Type': 'application/json'};
  //   var body = {
  //     "email": email,
  //     "password": password,
  //     "role": role.toString(),
  //     "fcmToken" : "$fcmToken"
  //   };
  //   var response = await ApiClient.postData(
  //       ApiConstants.signInEndPoint, jsonEncode(body),
  //       headers: headers);
  //   print("========================${response.statusCode} \n ${response.body}");
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var data = response.body['data']["user"];
  //     await PrefsHelper.setString(AppConstants.role, data['role']);
  //     await PrefsHelper.setString(AppConstants.bearerToken, response.body["data"]['token']);
  //     await PrefsHelper.setString(AppConstants.email, email);
  //     await PrefsHelper.setString(AppConstants.name, data['name']);
  //     await PrefsHelper.setString(AppConstants.phone, data['phone']);
  //     await PrefsHelper.setString(AppConstants.image, data['image']);
  //
  //     await PrefsHelper.setString(AppConstants.userId, data['_id']);
  //     await PrefsHelper.setBool(AppConstants.isLogged, true);
  //
  //
  //     final fcmToken = await PrefsHelper.getString(AppConstants.fcmToken);
  //     // FirebaseNotificationService.sendSocketEvent('fcmToken',
  //     //     {'userId': data['_id'], 'fcmToken': fcmToken});
  //
  //     var role = data['role'];
  //
  //     if (role == "user") {
  //       context.go(AppRoutes.userHomeScreen);
  //     }else{
  //       context.go(AppRoutes.managerHomeScreen);
  //       await PrefsHelper.setString(AppConstants.managerType, data['type']);
  //     }
  //     ToastMessageHelper.showToastMessage('Your are logged in');
  //     logInLoading(false);
  //   }else{
  //     ///******** When user do not able to verify their account thay have to verify there account then they can go to the app********
  //     if (response.body["message"] == "We've sent an OTP to your email to verify your profile.") {
  //       var role = response.body["data"]["role"];
  //       context.go(AppRoutes.otpScreen, extra: role.toString());
  //       await PrefsHelper.setString(AppConstants.bearerToken, response.body["data"]['token']);
  //       ToastMessageHelper.showToastMessage("We've sent an OTP to your email to verify your profile.");
  //     }else if(response.body["message"] == "⛔ Wrong password! ⛔"){
  //       ToastMessageHelper.showToastMessage(response.body["message"]);
  //     }
  //     logInLoading(false);
  //     ToastMessageHelper.showToastMessage(response.body['message']);
  //   }
  // }
  //
  //
  //
  // ///************************************************************************///
  //
  //
  // ///===============Forgot Password================<>
  // RxBool forgotLoading = false.obs;
  //
  // handleForgot(String email, screenType, {required BuildContext context}) async {
  //   forgotLoading(true);
  //   var body = {"email": email};
  //   var response = await ApiClient.postData(
  //       ApiConstants.forgotPasswordPoint, jsonEncode(body));
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //
  //     if(screenType == "forgot"){
  //       context.pushNamed(AppRoutes.otpScreen, extra: "Forgot Password");
  //       // context.pushNamed(AppRoutes.forgotPasswordScreen, extra: email.toString());
  //     }
  //
  //     forgotLoading(false);
  //   }  else {
  //     forgotLoading(false);
  //     ToastMessageHelper.showToastMessage(response.body["message"]);
  //   }
  // }
  //
  //
  // ///===============Set Password================<>
  //
  // RxBool setPasswordLoading = false.obs;
  //
  // setPassword(String password,{required BuildContext context}) async {
  //   setPasswordLoading(true);
  //   var body = {
  //     "password": password.toString().trim()
  //   };
  //
  //   var response = await ApiClient.postData(
  //       ApiConstants.setPasswordEndPoint, jsonEncode(body));
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     context.pushNamed(AppRoutes.loginScreen);
  //     ToastMessageHelper.showToastMessage('${response.body["message"]}');
  //     print("======>>> successful");
  //     setPasswordLoading(false);
  //   } else if(response.statusCode == 1){
  //     setPasswordLoading(false);
  //     ToastMessageHelper.showToastMessage("Server error! \n Please try later");
  //   } else {
  //     setPasswordLoading(false);
  //     ToastMessageHelper.showToastMessage('${response.body["message"]}');
  //   }
  // }
  //
  //
  // ///===============Resend================<>
  //
  // RxBool resendLoading = false.obs;
  //
  // reSendOtp() async {
  //   resendLoading(true);
  //   var body = {};
  //
  //   var response = await ApiClient.postData(
  //       ApiConstants.resendOtpEndPoint, jsonEncode(body));
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     ToastMessageHelper.showToastMessage(
  //         'You have got an one time code to your email');
  //     print("======>>> successful");
  //     resendLoading(false);
  //   }else{
  //     ToastMessageHelper.showToastMessage("${response.body["message"]}");
  //     resendLoading(false);
  //   }
  // }
  //
  //
  // ///===============Change Password================<>
  //
  // RxBool changePasswordLoading = false.obs;
  // changePassword(String oldPassword, newPassword) async {
  //   changePasswordLoading(true);
  //   var body = {
  //     "oldPassword": "$oldPassword",
  //     "newPassword": "$newPassword",
  //     "confirmPassword" : "$newPassword"
  //   };
  //
  //   var response =
  //   await ApiClient.postData(ApiConstants.changePassword, jsonEncode(body));
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     ToastMessageHelper.showToastMessage('Password Changed Successful');
  //     print("======>>> successful");
  //     changePasswordLoading(false);
  //   } else if(response.statusCode == 1){
  //     changePasswordLoading(false);
  //     ToastMessageHelper.showToastMessage("Server error! \n Please try later");
  //   } else {
  //     ToastMessageHelper.showToastMessage(response.body['message']);
  //     changePasswordLoading(false);
  //   }
  // }
  //
  //
  //
  //
  //
  //
  // final RxInt countdown = 180.obs;
  // final RxBool isCountingDown = false.obs;
  //
  //
  // void startCountdown() {
  //   isCountingDown.value = true;
  //   countdown.value = 180;
  //   update();
  //   Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (countdown.value > 0) {
  //       countdown.value--;
  //       update();
  //     } else {
  //       timer.cancel();
  //       isCountingDown.value = false;
  //       update();
  //     }
  //   });
  // }
  //
  //
  //
  //
  //


  void _dialog(BuildContext context, String role){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 24.w, vertical: 26.h),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // Align(
                  //     alignment: Alignment.center,
                  //     child: Assets.lottie.success.lottie(height: 80.h, width: 80.w, fit: BoxFit.cover)),

                  CustomText(
                    text: "SUCCESS",
                    fontsize: 23.h,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    top: 16.h,
                    bottom: 8.h,
                  ),


                  CustomText(
                    text: "Thank you for your request.",
                    color: Colors.black,
                    fontsize: 20.h,
                  ),

                  CustomText(
                    text: "Shortly you will find a confirmation in your email.",
                    color: Colors.black,
                    maxline: 2,
                    bottom: 24.h,
                  ),

                  CustomButton(title: "Go to App", onpress: (){
                    if(role == "user"){
                      // context.go(AppRoutes.userHomeScreen);
                    }else{
                      // context.go(AppRoutes.managerHomeScreen);
                    }
                  })
                ],
              ),
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                      width: 1.w, color: AppColors.primaryColor)));
        });
  }


}
