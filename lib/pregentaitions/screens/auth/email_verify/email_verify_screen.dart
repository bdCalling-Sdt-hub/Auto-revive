import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EmailVerifyScreen extends StatelessWidget {
  EmailVerifyScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(text: "E-mail Verification"),
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
          
          
              ///<<<=============>>> EMAIL FILED <<<===============>>>
          
              CustomTextField(
                  controller: emailCtrl,
                  hintText: "Enter E-mail",
                  prefixIcon: Assets.icons.mail.svg(),
                  isEmail: true),
          
          
          
              SizedBox(height: 111.h),
          
          
              ///<<<=============>>> SEND OTP <<<===============>>>
          
              CustomButton(title: "Send OTP", onpress: (){
                context.pushNamed(AppRoutes.otpScreen);
              }),
              SizedBox(height: 20.h),
          
          
            ],
          ),
        ),
      ),
    );
  }
}
