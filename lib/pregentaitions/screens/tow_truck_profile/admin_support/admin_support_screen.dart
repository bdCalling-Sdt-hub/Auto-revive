import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../controllers/settings_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_text.dart';


class AdminSupportScreen extends StatefulWidget {
  const AdminSupportScreen({super.key});

  @override
  State<AdminSupportScreen> createState() => _AdminSupportScreenState();
}

class _AdminSupportScreenState extends State<AdminSupportScreen> {
  SettingsController settingsController = Get.put(SettingsController());

  @override
  void initState() {
    settingsController.settingAdminSupport();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: "Admin Support",
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 80.h),
          /// ======================================> Image ===============================>
          Assets.images.adminSupport.image(),
          SizedBox(height: 40.h),
          /// ======================================> Text ===============================>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomText(
              text: 'SUPPORT',
              fontWeight: FontWeight.w600,
              fontsize: 35.sp,
              bottom: 8.h,
              color: AppColors.primaryColor,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomText(
              text: 'If you have any questions, need assistance, or want to discuss your progress, feel free to reach out to your coach. We re here to help you achieve your fitness goals!',
              fontWeight: FontWeight.w400,
              fontsize: 14.sp,
              maxline: 10,
              color: AppColors.textColor151515,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),
          Obx(()=>
             Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, color: Colors.blue, size: 20.sp),
                    SizedBox(width: 10.w),
                    CustomText(
                      text: settingsController.adminSupport.value.value?.phone ?? 'N/A',
                      textAlign: TextAlign.start,
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, color: Colors.blue, size: 20.sp),
                    SizedBox(width: 10.w),
                    CustomText(
                      text: settingsController.adminSupport.value.value?.email ?? 'N/A',
                      textAlign: TextAlign.center,
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),)




        ],
      ),
    );
  }
}
