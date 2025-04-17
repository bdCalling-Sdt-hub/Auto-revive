import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PersonalInformationScreen extends StatelessWidget {
  PersonalInformationScreen({super.key});

  final TextEditingController fullNameCtrl = TextEditingController();
  final TextEditingController platformCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();
  final TextEditingController currentAddressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(
          text: "Personal Information",
          fontsize: 20.sp,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.start,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 8 .h),
            ///<<<=============>>> PERCENT <<<===============>>>


            // Image and camera upload section
            GestureDetector(
              onTap: () {
                // Camera or gallery selection logic here
              },
              child: CircleAvatar(
                radius: 60.r,
                backgroundImage: AssetImage('path_to_your_image_or_camera_icon'),
                child: Icon(Icons.camera_alt, size: 40.sp),
              ),
            ),
            SizedBox(height: 38.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Full Name',
                  fontsize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor151515,
                ),
                SizedBox(height: 8.h),
                // Full Name field
                CustomTextField(
                  controller: fullNameCtrl,
                  hintText: "Enter Full Name",
                  // prefixIcon: Assets.icons.user.svg(),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Platform dropdown or text field (use if needed)
            CustomTextField(
              controller: platformCtrl,
              hintText: "Enter Platform",
              // prefixIcon: Assets.icons.platform.svg(),
            ),
            SizedBox(height: 16.h),

            // Email field
            CustomTextField(
                controller: emailCtrl,
                hintText: "Enter E-mail",
                // prefixIcon: Assets.icons.mail.svg(),
                isEmail: true),
            SizedBox(height: 16.h),

            // Phone Number field
            CustomTextField(
              controller: phoneNoCtrl,
              hintText: "Enter Phone Number",
              // prefixIcon: Assets.icons.phone.svg(),
            ),
            SizedBox(height: 16.h),

            // Address field
            CustomTextField(
              controller: currentAddressCtrl,
              hintText: "Enter Current Address",

            ),

            SizedBox(height: 50.h),

            // Save and Next button
            CustomButton(
              title: "Save and Next",
              onpress: () {
                // Action after saving data and moving to next screen
                context.pushNamed(AppRoutes.resetPasswordScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

