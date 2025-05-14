import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_slider.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../controllers/mechanic_controller/mechanic_job_controller.dart';

class MechanicJobScreen extends StatefulWidget {
  const MechanicJobScreen({super.key});

  @override
  State<MechanicJobScreen> createState() => _MechanicJobScreenState();
}

class _MechanicJobScreenState extends State<MechanicJobScreen> {
  MechanicJobController mechanicJobController = Get.put(MechanicJobController());

  bool status = false;
  double _miles = 2;

  @override
  void initState() {
    mechanicJobController.settingRadiusLimits().then((_) {
      final min = mechanicJobController.radiusLimits.value.value?.min ?? 0;
      setState(() {
        _miles = min.toDouble();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final radiusLimits = mechanicJobController.radiusLimits.value.value;
    final double min = radiusLimits?.min?.toDouble() ?? 0;
    final double max = radiusLimits?.max?.toDouble() ?? 100;

    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          maxline: 2,
          text: "Job",
          fontsize: 20.sp,
        ),
      ),
      body: Obx(() {
        if (mechanicJobController.radiusLimits.value.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            SizedBox(height: 32.h),

            /// ==================  Available button ==================
            CustomContainer(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    offset: const Offset(0, 4),
                    blurRadius: 4)
              ],
              paddingAll: 10.r,
              radiusAll: 100.r,
              color: AppColors.primaryShade300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterSwitch(
                    width: 62.w,
                    height: 32.h,
                    toggleSize: 32.r,
                    toggleColor: const Color(0xFF8A8AFF),
                    activeColor: AppColors.switchColor,
                    inactiveColor: AppColors.switchColor,
                    value: status,
                    borderRadius: 20.r,
                    padding: 0,
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                    },
                  ),
                  CustomText(
                    text: 'Available Now',
                    fontsize: 20.sp,
                    color: Colors.white,
                    left: 20.w,
                  )
                ],
              ),
            ),
            SizedBox(height: 24.h),

            /// ==================  Filter button ==================
            CustomContainer(
              width: double.infinity,
              radiusAll: 16.r,
              paddingAll: 24.r,
              color: AppColors.primaryShade300,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    offset: const Offset(0, 4),
                    blurRadius: 4)
              ],
              child: Column(
                children: [
                  CustomText(
                      text: 'Filter',
                      fontsize: 22.sp,
                      color: Colors.white,
                      bottom: 8.h),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        left: 16.w,
                        text: 'Miles From Me',
                        fontsize: 20.sp,
                        color: Colors.white,
                      )),
                  CustomSlider(
                    value: _miles,
                    min: min,
                    max: max,
                    onChanged: (val) {
                      setState(() {
                        _miles = val;
                      });
                    },
                  ),
                  CustomText(
                      text: 'Max: ${max.toInt()}',
                      fontsize: 12.sp,
                      color: Colors.white,
                      bottom: 4.h),
                  CustomContainer(
                    alignment: Alignment.center,
                    radiusAll: 12.r,
                    width: 95.w,
                    height: 42.h,
                    bordersColor: Colors.white,
                    child: CustomText(
                      text: _miles.toInt().toString(),
                      color: Colors.white,
                      fontsize: 16.sp,
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              title: 'Apply',
              onpress: () {
                context.pushNamed(
                  AppRoutes.mechanicJobRequestScreen,
                  extra: _miles.toInt().toString(),
                );
              },
            ),
            SizedBox(height: 20.h)
          ],
        );
      }),
    );
  }
}

