import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailVerifyScreen extends StatelessWidget {
  EmailVerifyScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "E-mail Verification"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [

            SizedBox(height: 138.h),


            Assets.icons.logoSVG.svg(),


            SizedBox(height: 38.h),


            CustomTextField(
                controller: emailCtrl,
                hintText: "Enter E-mail",
                prefixIcon: Assets.icons.mail.svg(),
                isEmail: true),




            CustomButton(title: "Send OTP", onpress: (){

            }),


          ],
        ),
      ),
    );
  }
}
