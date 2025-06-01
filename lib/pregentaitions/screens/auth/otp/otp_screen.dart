import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../controllers/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  final String screenType;
  final String email;

  OtpScreen({super.key, required this.screenType, required this.email});

   TextEditingController otpTEController = TextEditingController();
 final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(text: "OTP Verification"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
          
              ///<<<=============>>> LOGO <<<===============>>>
          
              Assets.icons.logoSVG.svg(),
          
              SizedBox(height: 38.h),
          
              ///<<<=============>>> OTP FILED <<<===============>>>
          
              CustomPinCodeTextField(textEditingController: otpTEController),
          
              SizedBox(height: 10.h),

              Row(
                children: [
                  CustomText(text: "Didn't got the code?"),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,

                    child: Obx(() =>
                        GestureDetector(

                      onTap: authController.isCountingDown.value
                          ? null
                          : () {
                        authController.startCountdown();
                        authController.reSendOtp('${email}');
                      },
                      child: CustomText(
                        text: authController.isCountingDown.value
                            ? 'Resend in ${authController.countdown.value}s'
                            : 'Resend code',
                        color: authController.isCountingDown.value
                            ? Colors.red
                            : AppColors.primaryColor,
                        fontsize: 12.sp,
                      ),
                    )),
                  ),
                ],
              ),

          
              SizedBox(height: 70.h),
          
              ///<<<=============>>> VERIFY <<<===============>>>
          
              Obx(
                () => CustomButton(
                    loading: authController.verfyLoading.value,
                    width: double.infinity,
                    title: "Verify",
                    onpress: () {
                      print("--------------------------- ${screenType}");
          
                      if(screenType == "Sign Up"){
                        // authController.verfyEmail(otpCtrl.text, screenType: "Sign Up", context: context);
                      }
                      if (screenType == "mechanic") {
                        authController.verfyEmail(otpTEController.text, screenType: screenType, context: context, type: "Sign Up");
                      }
                      else if(screenType == "tow_truck"){
                        authController.verfyEmail(otpTEController.text, screenType: "tow_truck", context: context,type: "Sign Up");
                      } else{
                        authController.verfyEmail(otpTEController.text, screenType: "forgot", context: context);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPinCodeTextField extends StatelessWidget {
  final TextEditingController? textEditingController;

  const CustomPinCodeTextField({super.key, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      backgroundColor: Colors.transparent,
      cursorColor: AppColors.primaryColor,
      controller: textEditingController,
      textStyle: const TextStyle(color: AppColors.textColor6B6B6B),
      autoFocus: false,
      appContext: context,
      length: 6,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          selectedColor: AppColors.primaryColor,
          activeFillColor: AppColors.primaryColor,
          selectedFillColor: AppColors.primaryColor,
          inactiveFillColor: AppColors.primaryColor,
          fieldHeight: 55.h,
          fieldWidth: 50.w,
          inactiveColor: AppColors.borderColor,
          activeColor: AppColors.primaryColor),
      obscureText: false,
      keyboardType: TextInputType.number,
      onChanged: (value) {},
      onCompleted: (value) {
        textEditingController?.text = value;
      },
    );
  }
}
