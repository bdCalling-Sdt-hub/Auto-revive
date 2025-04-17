import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 138.h),

            ///<<<=============>>>   Logo Icon   <<<===============>>>

            Assets.icons.logoSVG.svg(),


            SizedBox(height: 38.h),


            ///<<<=============>>>   Email Filed   <<<===============>>>

            CustomTextField(
                controller: emailCtrl,
                hintText: "Enter E-mail",
                prefixIcon: Assets.icons.mail.svg(),
                isEmail: true),



            ///<<<=============>>>   Password Filed   <<<===============>>>

            CustomTextField(
                controller: passCtrl,
                hintText: "Enter Password",
                prefixIcon: Assets.icons.key.svg(),
                isPassword: true),


            ///<<<=============>>> Forgot filed <<<===============>>>

            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutes.emailVerifyScreen);
                  },
                  child: CustomText(text: "Forgot Password", color: Colors.red, bottom: 20.h, top: 8.h)),
            ),



            ///<<<=============>>> BUTTON <<<===============>>>

            CustomButton(title: "Let's Go", onpress: (){

            }),


            SizedBox(height: 40.h),

            ///<<<=============>>> DO NOT HAVE ACCOUNT <<<===============>>>

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: "Don't have an account?"),
                GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.roleScreen);
                    },
                    child: CustomText(text: "  Sign Up", color: AppColors.primaryColor)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
