import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: CustomText(
          color: AppColors.primaryColor,
          text: "Earnings",
          fontsize: 16.sp,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          CustomContainer(
            paddingAll: 24.r,
            radiusAll: 16.r,
            color: AppColors.primaryShade300,
            child: Column(
              children: [
                CustomText(
                  text: 'Your balance',
                  color: Colors.white,
                  fontsize: 20.sp,
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: '\$240',
                  color: Colors.white,
                  fontsize: 32.sp,
                ),
                SizedBox(height: 10.h),
                CustomButton(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    titlecolor: AppColors.primaryColor,
                    color: AppColors.bgColorWhite,
                    title: 'Withdraw Now',
                    onpress: () {
                      context.pushNamed(AppRoutes.withdrawScreen);
                    }),
              ],
            ),
          ),
          CustomText(
            top: 10.h,
            bottom: 10.h,
            textAlign: TextAlign.start,
            text: 'Earnings History',
            fontsize: 24.sp,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return CustomContainer(
                    verticalMargin: 5.h,
                    paddingAll: 10.r,
                    radiusAll: 16.r,
                    linearColors: const [
                      Color(0xff407BFF),
                      Color(0xff3C2E93),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          offset: const Offset(0, 4),
                          blurRadius: 4)
                    ],
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CustomImageAvatar(
                        image: '',
                      ),
                      title: CustomText(
                        text: 'Jeorge Mayank',
                        color: Colors.white,
                        textAlign: TextAlign.start,
                      ),
                      subtitle: CustomText(
                        text: 'Transition id :  374364736 \n21 April 2025',
                        color: Colors.white,
                        textAlign: TextAlign.start,
                        fontsize: 10.sp,
                      ),
                      trailing: CustomText(
                        right: 24.w,
                        text: '\$ 23',
                        color: Colors.white,
                        textAlign: TextAlign.start,
                        fontsize: 28.sp,
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
