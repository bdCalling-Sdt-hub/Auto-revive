import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/cachanetwork_image.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/custom_text.dart';

class CustomerBookingDetailsScreen extends StatelessWidget {
  const CustomerBookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Complete"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomNetworkImage(
                    imageUrl: "https://randomuser.me/api/portraits/men/20.jpg",
                    boxShape: BoxShape.circle,
                    height: 110.h,
                    width: 110.w,
                    border: Border.all(color: AppColors.primaryColor)),
                SizedBox(width: 18.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "David Bryan",
                        color: Colors.black,
                        fontsize: 22.h),
                    Row(
                      children: [
                        CustomText(text: "New York, USA", color: Colors.black),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            height: 13.h,
                            width: 1.w,
                            color: Colors.grey),
                        Icon(Icons.star, color: Colors.amber, size: 20.h),
                        CustomText(
                            text: "4.10", fontsize: 12.h, color: Colors.black)
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryShade300,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 6.w),
                            child: Row(
                              children: [
                                Assets.icons.profileIcon.svg(),
                                SizedBox(width: 10.w),
                                CustomText(
                                    text: "Profile",
                                    color: Colors.white,
                                    fontsize: 12.h),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryShade300,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 6.w),
                            child: Row(
                              children: [
                                Assets.icons.mail.svg(),
                                SizedBox(width: 10.w),
                                CustomText(
                                    text: "Message",
                                    color: Colors.white,
                                    fontsize: 12.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            CustomText(
                text: "Problem which need to solve that's price",
                color: Colors.black,
                fontsize: 20.h,
                maxline: 2,
                textAlign: TextAlign.start,
                top: 30.h),




            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: AppColors.primaryShade300
              ),
              child: CustomText(text: r"$ 10", fontsize: 48.h, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
