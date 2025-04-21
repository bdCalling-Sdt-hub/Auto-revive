import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_linear_indicator.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_upload_button.dart';

class MechanicResumeCertificateScreen extends StatelessWidget {
  const MechanicResumeCertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: "Resume and Certificate",
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
                progressValue: 0.9,
              ),
              SizedBox(height: 20.h),
              CustomText(text: "Upload your resume and certificates to complete your mechanic profile. Showcase your skills, experience, and certifications to attract more customers. A complete profile increases trust and boosts your chances of getting hired. Get started now and stand out as a professional mechanic! ",
                  maxline: 15,
                  textAlign: TextAlign.start,
                  fontsize: 13.sp,
                  color: AppColors.textColor151515),
              SizedBox(height: 29.h),
              CustomUploadButton(
                // topLabel: 'Upload Resume',
                title: 'Upload Resume',
                icon: Icons.upload,
                onTap: () {},
              ),
              SizedBox(height: 5.h),
              CustomUploadButton(
                // topLabel: 'Upload Resume',
                title: 'Upload Certificate',
                icon: Icons.upload,
                onTap: () {},
              ),
              SizedBox(height: 350.h),

              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              CustomButton(
                title: "Submit",
                onpress: () {
                  // Action after saving data and moving to next screen
                  context.pushNamed(AppRoutes.mechanicProfileInformationScreen );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
