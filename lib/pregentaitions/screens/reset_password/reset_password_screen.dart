import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController rePassCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(text: "Reset Password"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [

            SizedBox(height: 16.h),

            ///<<<=============>>> LOGO <<<===============>>>

            Assets.icons.logoSVG.svg(),


            SizedBox(height: 38.h),


            ///<<<=============>>> EMAIL FILED <<<===============>>>

            CustomTextField(
                controller: passCtrl,
                hintText: "Enter Password",
                prefixIcon: Assets.icons.mail.svg(),
                isPassword: true),




            ///<<<=============>>> EMAIL Re Password <<<===============>>>


            CustomTextField(
                controller: passCtrl,
                hintText: "Enter Re-enter Password",
                prefixIcon: Assets.icons.mail.svg(),
                isPassword: true),



            SizedBox(height: 111.h),


            ///<<<=============>>> SEND OTP <<<===============>>>

            CustomButton(title: "Confirm", onpress: (){
              context.pushNamed(AppRoutes.otpScreen);
            }),


          ],
        ),
      ),
    );
  }
}
