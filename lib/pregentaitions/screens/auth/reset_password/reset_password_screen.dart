import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController rePassCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(text: "Reset Password"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                    controller: rePassCtrl,
                    hintText: "Enter Re-enter Password",
                    prefixIcon: Assets.icons.mail.svg(),
                    isPassword: true),
            
            
            
                SizedBox(height: 111.h),
            
            
                ///<<<=============>>> SEND OTP <<<===============>>>
            
                Obx(()=>
                 CustomButton(
                   loading: authController.setPasswordLoading.value,
                     title: "Confirm",
                     onpress: (){
                       if(formKey.currentState!.validate()){
                         authController.setPassword(
                             passCtrl.text,
                             rePassCtrl.text,
                             context: context);
            
                       }
                  }),),
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
