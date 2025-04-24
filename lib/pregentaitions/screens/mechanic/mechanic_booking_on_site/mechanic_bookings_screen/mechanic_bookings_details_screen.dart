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

class MechanicBookingsDetailsScreen extends StatelessWidget {
  const MechanicBookingsDetailsScreen({super.key});

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
                      GestureDetector
                        (
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
          SizedBox(height: 26.h),
          // ============>> Service Search and Selection <<============= //
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  fontsize: 20.sp,
                  color: AppColors.textColor151515,
                  text: 'Problem which need to solve..',
                ),
                SizedBox(height: 18.h),
                // Search Box
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Service Name',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.search, color: AppColors.primaryShade300),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // Scrollable Services List
                Container(
                  height: 300.h,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryShade300),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Scrollbar(
                    thickness: 4,
                    radius: Radius.circular(8.r),
                    child: ListView(
                      children: [
                        _buildServiceTile('Diesel Engine Repair', '\$27'),
                        _buildServiceTile('Gasoline Engine Repair', '\$27'),
                        _buildServiceTile('Semi-Truck Repair', '\$27'),
                        _buildServiceTile('Trailer Repair', '\$27'),
                        _buildServiceTile('RV Repair', '\$23', checked: true),
                        _buildServiceTile('Brake Systems', '', isEnabled: true),
                        _buildServiceTile('Welding/Fabrication', '', isEnabled: true),
                        _buildServiceTile('Other', '', isEnabled: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
          CustomButton(title: 'Submit',
              onpress: () {
                context.pushNamed(AppRoutes.mechanicCompleteDetailsScreen);


              }),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildServiceTile(String name, String price, {bool checked = false, bool isEnabled = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: isEnabled ? (v) {} : null,
            activeColor: Colors.blue,
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isEnabled ? Colors.black : Colors.grey,
                decoration: isEnabled ? null : TextDecoration.lineThrough,
              ),
            ),
          ),
          if (price.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: checked ? Colors.grey.shade300 : Colors.transparent,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(price),
            ),
        ],
      ),
    );
  }
}

