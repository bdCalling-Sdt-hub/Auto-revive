import 'package:autorevive/core/app_constants/app_constants.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/helpers/prefs_helper.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_routes/app_routes.dart';


class RoleScreen extends StatelessWidget {
  RoleScreen({super.key});

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
            SizedBox(height: 38.h),
            Assets.icons.logoSVG.svg(),


            SizedBox(height: 19.h),
            CustomText(
              text: 'Sign up as a',
              fontsize: 28.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              color: AppColors.textColor222222,
            ),
            SizedBox(height: 19.h),
            CustomButton(
                title: "Customer",
                onpress: (){
                  PrefsHelper.setString(AppConstants.role, "customer");
                  context.pushNamed(AppRoutes.customerSignupScreen);
            }),
           SizedBox(height: 10.h),
            CustomButton(
                title: "Mechanic or automotive shop",
                onpress: (){
                  PrefsHelper.setString(AppConstants.role, "mechanic");
                  context.pushNamed(AppRoutes.mechanicProfileInformationScreen);
                  // context.pushNamed(AppRoutes.mechanicBottomNavBar);
            }),
            SizedBox(height: 10.h),
            CustomButton(
                title: "Tow Truck Operator",
                onpress: (){
                  PrefsHelper.setString(AppConstants.role, "tow_truck");
                  context.pushNamed(AppRoutes.basicInfoScreen);


                }),



          ],
        ),
      ),
    );
  }
}
