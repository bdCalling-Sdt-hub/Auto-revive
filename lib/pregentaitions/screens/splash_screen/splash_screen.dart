import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Assets.images.splashImage.image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.4),
            colorBlendMode: BlendMode.darken),
        Center(
          child: Column(
            children: [
              SizedBox(height: 343.h),
              Assets.icons.logoSVG.svg(color: AppColors.fontColorFFFFFF),
              CustomText(
                  text: "Fast & Reliable Repair \nat Your Fingertips!",
                  fontsize: 25.h,
                  color: AppColors.fontColorFFFFFF)
            ],
          ),
        )
      ],
    ));
  }
}
