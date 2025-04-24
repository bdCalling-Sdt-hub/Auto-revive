import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_linear_indicator.dart';
import '../../../../widgets/custom_text.dart';

class MechanicAdditionalInformationScreen extends StatefulWidget {
  const MechanicAdditionalInformationScreen({super.key});

  @override
  State<MechanicAdditionalInformationScreen> createState() => _MechanicAdditionalInformationScreenState();
}


final TextEditingController additionController = TextEditingController();

class _MechanicAdditionalInformationScreenState extends State<MechanicAdditionalInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: "Additional Information",
          fontsize: 20.sp,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.start,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              ///<<<=============>>> LinearIndicator <<<===============>>>
              const CustomLinearIndicator(
                progressValue: 0.8,
              ),
              SizedBox(height: 20.h),
              CustomText(text: "Why do you want to work at On-Site Fleet Services?",
                  maxline: 2,
                  textAlign: TextAlign.start,
                  fontsize: 20.sp,
                  color: AppColors.textColor151515),
              SizedBox(height: 25.h),
              Container(
                width: 342,
                height: 107,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryShade300, width: 0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: TextField(
                    controller: additionController,
                    maxLines: 15,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write some things...',
                      hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.textColor151515),
                      isCollapsed: true,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 400.h),

              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              CustomButton(
                title: "Save and Next",
                onpress: () {
                  // Action after saving data and moving to next screen
                  context.pushNamed(AppRoutes.mechanicResumeCertificateScreen);
                },
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}
