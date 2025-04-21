import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Stack(
      children: [
        Assets.images.onboardingImage.image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.4),
            colorBlendMode: BlendMode.darken),
        Center(
          child: Column(
            children: [
              SizedBox(height: 108.h),
              Assets.icons.logoSVG.svg(color: Colors.white),
              SizedBox(height: 226.h),
              CustomText(
                  text: "Fast & Reliable Repair \nat Your Fingertips!",
                  fontsize: 25.h,
                  bottom: 24.h,
                  color: const Color(0xffB0B0FF)),
              CustomText(
                  text:
                      "Get expert auto repair solutions and services, \ntailored to keep your vehicle in top shape.",
                  maxline: 2,
                  bottom: 48.h,
                  color: AppColors.fontColorFFFFFF),



              
              
              CustomButton(
                  color: AppColors.primaryColorTransparent,
                  title: "Start Your Journey !", onpress: (){
                context.goNamed(AppRoutes.logInScreen);
              })
            ],
          ),
        )
      ],
    ));
  }
}
