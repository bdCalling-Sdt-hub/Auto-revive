import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/custom_linear_indicator.dart';


class MechanicEmploymentHistoryScreen extends StatefulWidget {
  MechanicEmploymentHistoryScreen({super.key});
  @override
  State<MechanicEmploymentHistoryScreen> createState() => _MechanicEmploymentHistoryScreenState();
}
class _MechanicEmploymentHistoryScreenState extends State<MechanicEmploymentHistoryScreen> {

  final TextEditingController companyNameCtrl = TextEditingController();
  final TextEditingController jobTitleCtrl = TextEditingController();
  final TextEditingController supervisorsNameCtrl = TextEditingController();
  final TextEditingController supervisorsContactCtrl = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: "Employment History",
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
                progressValue: 0.03,
                label: 0,
              ),
              SizedBox(height: 20.h),
              CustomText(text: "Most recent employers",
                  fontsize: 20.sp,
                  color: AppColors.textColor151515),
              SizedBox(height: 8.h),
              ///<<<=============>>> Company Name Field <<<===============>>>
              CustomText(
                  text: "Company Name:"),
              SizedBox(height: 8.h),
              CustomTextField(controller: companyNameCtrl, hintText: "Company name"),

              ///<<<=============>>> Job Title Field <<<===============>>>
              CustomText(
                  text: "Job Title:"),
              SizedBox(height: 8.h),
              CustomTextField(
                readOnly: true,
                controller: jobTitleCtrl,
                hintText: "Job Title",
              ),
              ///<<<=============>>> Supervisors Name Field <<<===============>>>
              CustomText(
                  text: "Supervisors Name:"),
              SizedBox(height: 8.h),
              CustomTextField(
                  controller: supervisorsNameCtrl,
                  hintText: "Supervisors Name"),
              ///<<<=============>>> Supervisors Contact <<<===============>>>
              CustomText(
                  text: "Supervisors Contact:"),
              SizedBox(height: 8.h),
              CustomTextField(
                  controller: supervisorsContactCtrl,
                  hintText: "Supervisors Contact"),
              ///<<<=============>>> Employment Duration <<<===============>>>
              CustomText(text: 'Employment Duration:'),
              Row(
                children: [

                ],
              ),


              SizedBox(height: 31.h),

              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              CustomButton(
                title: "Save and Next",
                onpress: () {
                  // Action after saving data and moving to next screen
                  context.pushNamed(AppRoutes.mechanicExperienceSkillScreen);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDate({required bool isStart}) async {
    DateTime initialDate = isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now());
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null; // End date can't be before start date
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }


}

