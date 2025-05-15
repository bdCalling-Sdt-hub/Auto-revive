import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/app_routes/app_routes.dart';

class MechanicCompleteDetailsScreen extends StatelessWidget {
   MechanicCompleteDetailsScreen({super.key});

  final List<String> services = [
    "Diesel Engine Repair",
    "Gasoline Engine Repair",
    "Semi-Truck Repair",
    "Trailer Repair",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          maxline: 2,
          text: "Details",
          fontsize: 20.sp,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImageAvatar(image: '', radius: 44.r),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'David Bryan',
                    fontsize: 20.sp,
                    bottom: 6.h,
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'New York, USA '),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      Assets.icons.detailsMessage.svg(),
                      SizedBox(width: 6.w),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.mechanicMapScreen);
                        },
                          child: Assets.icons.detailsLocation.svg()),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Align(
            alignment: Alignment.topLeft,
            child: CustomText(
              textAlign: TextAlign.start,
              fontsize: 20.sp,
              color: AppColors.textColor151515,
              text: 'Problem(s) need to be solved',
            ),
          ),
          SizedBox(height: 18.h),
          Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 22.w),
          height: 317.h,
          decoration: BoxDecoration(
            color: AppColors.bgColorWhite,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.primaryShade300, width: 0.4),
          ),
          child: Scrollbar(
            thickness: 4.w,
            radius: Radius.circular(4.r),
            child: ListView.separated(
              padding: EdgeInsets.all(8.w),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.only(top: index == 0 ? 22.h : 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16.w,
                            height: 16.h,
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          CustomText(text: services[index], color: Colors.black),
                        ],
                      ),
                      CustomText(text: r"$ 27", right: 22.w, color: Colors.black),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
            ),
          ),
        ),
          const Spacer(),
          CustomButton(title: 'Complete', onpress: () {
          }),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
