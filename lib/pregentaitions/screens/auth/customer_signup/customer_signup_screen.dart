import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_upload_button.dart';

class CustomerSignupScreen extends StatelessWidget {
  CustomerSignupScreen({super.key});

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: CustomText(text: "As a Customer", fontsize: 18.h),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48.h),
          
              ///<<<=============>>> Name Filed <<<===============>>>
          
              CustomText(
                  text: "Your Name",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(controller: nameCtrl, hintText: "Enter your name"),
          
          
          
          
              ///<<<=============>>> Email Filed <<<===============>>>
          
              CustomText(
                  text: "E-mail",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(controller: emailCtrl, hintText: "Enter your e-mail"),
          
          
          
              ///<<<=============>>> PHONE FIELD <<<===============>>>
          
              CustomText(
                  text: "Phone No.",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(controller: phoneCtrl, hintText: "Enter your phone"),
          
          
          
              ///<<<=============>>> ADDRESS Filed <<<===============>>>
          
              CustomText(
                  text: "Address",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(controller: addressCtrl, hintText: "Enter your address"),
          
          
          
              ///<<<=============>>> DRIVING LICENSE OR PASSPORT Filed <<<===============>>>
          
              CustomText(
                  text: "Upload driving license or passport",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
          
          
              CustomUploadButton(
                topLabel: 'Upload Proof of MC authority',
                title: 'mc.pdf',
                icon: Icons.upload,
                onTap: () {},
              ),
          
          
          
          
              ///<<<=============>>> PASSWORD Filed <<<===============>>>
          
              CustomText(
                  text: "Password",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(controller: passwordCtrl, hintText: "Enter your password", prefixIcon: Assets.icons.key.svg(), isPassword: true),
          
          
          
          
              ///<<<=============>>>CONFIRM PASSWORD Filed <<<===============>>>
          
              CustomText(
                  text: "Confirm Password",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(controller: confirmPasswordCtrl, hintText: "Re-enter your password",  prefixIcon: Assets.icons.key.svg(), isPassword: true),
          
          
          
          
          
          
              CustomButton(title: "Sign Up", onpress: () {
                context.pushNamed(AppRoutes.customerBottomNavBar);
              },),

              SizedBox(height: 20.h)
            ],
          ),
        ),
      ),
    );
  }
}
