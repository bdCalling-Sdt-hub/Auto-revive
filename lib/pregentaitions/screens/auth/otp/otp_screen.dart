import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TextEditingController otpTEController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(text: "OTP Verification"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Didn't got the code?"),

                CustomText(text: "Resend", color: Colors.red)
              ],
            ),


            SizedBox(height: 70.h),


            ///<<<=============>>> VERIFY <<<===============>>>

            CustomButton(title: "Verify", onpress: (){

            }),


          ],
        ),
      ),
    );
  }
}




class CustomPinCodeTextField extends StatelessWidget {
  final TextEditingController? textEditingController;


  const CustomPinCodeTextField({super.key,this.textEditingController});


  @override
  Widget build(BuildContext context) {
    return  PinCodeTextField(
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
    );
  }
}