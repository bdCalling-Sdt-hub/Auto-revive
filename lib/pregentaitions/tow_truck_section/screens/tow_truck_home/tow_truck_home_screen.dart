import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_text.dart';

class TowTruckHomeScreen extends StatelessWidget {
  const TowTruckHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [


          Assets.images.customerHomeScreenImage.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.7),
              colorBlendMode: BlendMode.darken),



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






          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Assets.icons.logoSVG.svg(color: AppColors.bgColorWhite, height: 50.h),
                      const  Spacer(),
                      Assets.icons.timeProgress.svg(),
                      SizedBox(width: 20.w),
                      Assets.icons.notificationIcon.svg()
                    ],
                  ),

                  SizedBox(height: 90.h),
                  Assets.icons.logoSVG.svg(color: Colors.white),
                  SizedBox(height: 27.h),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      textAlign: TextAlign.start,
                      maxline: 2,
                        text: "Delivering top-notch service...",
                        fontsize: 35.h,
                        bottom: 24.h,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),


                  CustomText(
                      text: "Find a mechanic or tow truck easily with our app—quick, reliable service whenever you need it, wherever you are.",
                      maxline: 3,
                      fontsize: 18.h,
                      textAlign: TextAlign.start,
                      bottom: 48.h, color: Colors.white),




                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.towTruckJobScreen);
                    },
                    child: CustomContainer(
                      paddingAll: 10.h,
                      width: double.infinity,
                          radiusAll: 4.r,
                          color: Colors.white,
                      child: CustomText(text: "Let's Get Started!", color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),












        ],
      ),
    );
  }
}
