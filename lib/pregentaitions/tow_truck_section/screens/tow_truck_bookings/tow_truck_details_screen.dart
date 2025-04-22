import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TowTruckDetailsScreen extends StatelessWidget {
  const TowTruckDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            maxline: 2,
            text: "Details",
            fontsize: 20.sp,
          )),
      body: Column(
        children: [
          SizedBox(height: 44.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageAvatar(
                image: '',
                radius: 44.r,
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: CustomText(
                      textAlign: TextAlign.start,
                      text: 'David Bryan',
                      fontsize: 20.sp,
                      bottom: 6.h,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 120.w,
                          child: CustomText(
                            text: 'New York, USA  |  ',
                          )),
                      Icon(
                        Icons.star,
                        size: 16.r,
                        color: Colors.amber,
                      ),
                      CustomText(
                        text: ' 4.85',
                      ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      Assets.icons.detailsMessage.svg(),
                      SizedBox(width: 6.w),
                      Assets.icons.detailsLocation.svg(),
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 44.w),
          CustomContainer(
            paddingAll: 32.r,
            radiusAll: 16.r,
            color: AppColors.primaryColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle_rounded,
                      size: 14.r,
                      color: Colors.white,
                    ),
                    Flexible(
                      child: CustomText(
                        text: 'New York, USA',
                        color: Colors.white,
                        left: 2.w,
                        fontsize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle_rounded,
                      size: 14.r,
                      color: Colors.white,
                    ),
                    Flexible(
                      child: CustomText(
                          text: 'California, USA',
                          color: Colors.white,
                          left: 2.w,
                          fontsize: 12.sp),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text: 'Total Distance: 23 KM',
                  color: Colors.white,
                  fontsize: 20.sp,
                ),
              ],
            ),
          ),
          const Spacer(),
          CustomButton(title: 'Complete', onpress: () {}),
        ],
      ),
    );
  }
}
