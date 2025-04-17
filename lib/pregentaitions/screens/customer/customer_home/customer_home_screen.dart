import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Assets.images.customerHomeScreenImage.image(
              fit: BoxFit.fill,
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


              ],
            ),
          ),







          // Bottom elevation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
