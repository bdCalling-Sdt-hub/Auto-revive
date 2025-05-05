import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/upload_controller.dart';
import '../../../widgets/custom_text.dart';

class MechanicSignupScreen extends StatefulWidget {
  MechanicSignupScreen({super.key});

  @override
  State<MechanicSignupScreen> createState() => _MechanicSignupScreenState();
}

class _MechanicSignupScreenState extends State<MechanicSignupScreen> {

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: CustomText(text: "As a Mechanic", fontsize: 18.h),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: fromKey,
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

                SizedBox(height: 240.h),
                Obx(()=>
                    CustomButton(
                      loading: authController.mechanicSignUpLoading.value,
                      title: "Sign Up",
                      onpress: () {
                        if(fromKey.currentState!.validate()){
                          authController.mechanicHandleSignUp(
                            context: context,
                            name: nameCtrl.text,
                            email: emailCtrl.text,
                            password: passwordCtrl.text.trim(),
                            confirmPassword: confirmPasswordCtrl.text.trim(),
                          );
                        }
                      },),
                ),
                SizedBox(height: 20.h)
              ],
            ),
          ),
        ),
      ),
    );

  }



}
