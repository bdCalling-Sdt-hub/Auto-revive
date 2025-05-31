
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';



class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final TextEditingController newPasswordCTRl = TextEditingController();
  final TextEditingController conformPasswordCTRl = TextEditingController();
  final TextEditingController currentPasswordCTRl = TextEditingController();
  AuthController authController = Get.find<AuthController>();

  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: false,
        centerTitle: true,
        title: CustomText(text: "Change Password", fontsize: 20.h),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: fromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 17.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// =====================================> Current Password ===================================>
                    CustomText(
                      text: 'Current Password',
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor151515,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: currentPasswordCTRl,
                      hintText: 'Enter current password',
                      // prefixIcon: 'assets/icons/lock.svg',
                      isObscureText: true,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your current password";
                        }
                        return null;
                      },
                      contentPaddingHorizontal: 20.w,
                      contentPaddingVertical: 18.h,
                    ),
                    /// =====================================> New Password ===================================>
                    CustomText(
                      text: 'New Password',
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor151515,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: newPasswordCTRl,
                      hintText: 'Enter new password',
                      // prefixIcon: 'assets/icons/lock.svg',
                      isObscureText: true,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your new password";
                        }
                        return null;
                      },
                      contentPaddingHorizontal: 20.w,
                      contentPaddingVertical: 18.h,
                    ),
                    /// =====================================> Confirm New Password ===================================>
                    CustomText(
                      text: 'Confirm New Password',
                      fontsize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor151515,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: conformPasswordCTRl,
                      hintText: 'Enter confirm password',
                      // prefixIcon: 'assets/icons/lock.svg',
                      isObscureText: true,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your confirm password";
                        }
                        return null;
                      },
                      contentPaddingHorizontal: 20.w,
                      contentPaddingVertical: 18.h,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        textAlign: TextAlign.end,
                          fontsize: 16.sp ,
                          color: AppColors.redColors,
                          text: 'Forget Password?'),
                    ),

                    SizedBox(height: 300.h),
                   Obx(()=>
                     CustomButton(
                       loading: authController.changePasswordLoading.value,
                       title: 'Change Password',
                       onpress: () {
                         if (fromKey.currentState!.validate()) {
                           authController.changePassword(
                             currentPasswordCTRl.text,
                             newPasswordCTRl.text,
                             conformPasswordCTRl.text,
                           );
                         }
                       },
                     ),
                   ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

            ],
          ),
        ),
      ),
    );
  }

}
