import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

import '../../../../controllers/auth_controller.dart';

class EmailVerifyScreen extends StatefulWidget {
  final String email;
  EmailVerifyScreen({super.key,required this.email});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {

  final TextEditingController emailCtrl = TextEditingController();
  AuthController authController = Get.find<AuthController>();

  final GlobalKey<FormState> _logKey = GlobalKey<FormState>();


  @override
  void initState() {
    print("====================${widget.email}");
    setState(() {
      emailCtrl.text = widget.email;
    });
    super.initState();
  }

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
          child: Form(
            key: _logKey,
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

                Obx(()=>
                  CustomButton(
                    loading: authController.forgotLoading.value,
                      title: "Send OTP",
                      onpress: (){
                        if(_logKey.currentState!.validate()){
                          authController.handleForgot(emailCtrl.text, "forgot", context: context);
                        }
                  }),
                ),
                SizedBox(height: 20.h),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
