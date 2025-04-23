import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/custom_checkbox_list.dart';
import '../../../../widgets/custom_linear_indicator.dart';


class MechanicEmploymentHistoryScreen extends StatefulWidget {
  MechanicEmploymentHistoryScreen({super.key});
  @override
  State<MechanicEmploymentHistoryScreen> createState() => _MechanicEmploymentHistoryScreenState();
}
class _MechanicEmploymentHistoryScreenState extends State<MechanicEmploymentHistoryScreen> {


  final TextEditingController reasonLeavingCtrl = TextEditingController();

  final TextEditingController companyNameCtrl = TextEditingController();
  final TextEditingController jobTitleCtrl = TextEditingController();
  final TextEditingController supervisorsNameCtrl = TextEditingController();
  final TextEditingController supervisorsContactCtrl = TextEditingController();


  TextEditingController dateCtrl = TextEditingController();

  final Map<String, bool> workSettingCheckbox = {
    'In-Shop': false,
    'On-Site': false,
    'Both': false,
  };
  final TextEditingController fromDateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                progressValue: 0.4,
              ),
              SizedBox(height: 20.h),
              CustomText(text: "Most recent employers",
                  fontsize: 20.sp,
                  color: AppColors.textColor151515),
              SizedBox(height: 8.h),
              ///<<<=============>>> Company Name Field <<<===============>>>
              CustomText(
                  text: "Company Name:",color: AppColors.textColor151515,fontsize: 14.sp),
              SizedBox(height: 8.h),
              CustomTextField(controller: companyNameCtrl, hintText: "Company name"),

              ///<<<=============>>> Job Title Field <<<===============>>>
              CustomText(
                  text: "Job Title:",color: AppColors.textColor151515,fontsize: 14.sp),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: jobTitleCtrl,
                hintText: "Job Title",
              ),
              ///<<<=============>>> Supervisors Name Field <<<===============>>>
              CustomText(
                  text: "Supervisors Name:",color: AppColors.textColor151515,fontsize: 14.sp),
              SizedBox(height: 8.h),
              CustomTextField(
                  controller: supervisorsNameCtrl,
                  hintText: "Supervisors Name"),
              ///<<<=============>>> Supervisors Contact <<<===============>>>
              CustomText(
                  text: "Supervisors Contact:",color: AppColors.textColor151515,fontsize: 14.sp),
              SizedBox(height: 8.h),
              CustomTextField(
                  controller: supervisorsContactCtrl,
                  hintText: "Supervisors Contact"),
              ///<<<=============>>> Employment Duration <<<===============>>>
              CustomText(text: 'Employment Duration:',color: AppColors.textColor151515,fontsize: 14.sp),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 18.h,horizontal: 25.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                final formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                fromDateCtrl.text = formattedDate;
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextField(
                                readOnly: true,
                                controller: fromDateCtrl,
                                hintText: "From Date",
                                suffixIcon: const Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 16.h),
                    // CustomText(text: 'To',fontsize: 14.sp,fontWeight: FontWeight.bold,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                final formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                dateCtrl.text = formattedDate;
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextField(
                                readOnly: true,
                                controller: dateCtrl,
                                hintText: "Select Date",
                                suffixIcon: const Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///<<<=============>>> Work Setting <<<===============>>>
              CustomText(text: 'Work Setting:',color: AppColors.textColor151515,fontsize: 14.sp),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                child: CustomCheckboxList(
                  items: workSettingCheckbox,
                ),
              ),
              ///<<<=============>>> Reason for leaving <<<===============>>>
              CustomText(text: 'Reason for leaving:',color: AppColors.textColor151515,fontsize: 14.sp ),
              SizedBox(height: 10.h),
              Container(
                width: 342,
                height: 107,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textColor151515, width: 0.8),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: TextField(
                    controller: reasonLeavingCtrl,
                    maxLines: 5,
                    style: TextStyle(fontSize: 10.sp),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Leaving a job can be a tough decision, whether for growth, work-life balance, or a new opportunity...',
                      hintStyle: TextStyle(fontSize: 10.sp, color:AppColors.textColor151515),
                      isCollapsed: true,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 77.h),

              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              CustomButton(
                title: "Save and Next",
                onpress: () {
                  // Action after saving data and moving to next screen
                  context.pushNamed(AppRoutes.mechanicReferenceScreen);
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

