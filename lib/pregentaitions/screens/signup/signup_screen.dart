import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        CustomText(
            text: "Sign Up",
          fontsize: 20.sp,

        ),


      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [

            SizedBox(height: 138.h),


            Assets.icons.logoSVG.svg(),


            SizedBox(height: 38.h),
            CustomText(
              text: 'Sign up as a',
              fontsize: 28.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: AppColors.textColor222222,
            ),






            CustomButton(
                title: "Customer",
                onpress: (){

            }),


          ],
        ),
      ),
    );
  }
}
