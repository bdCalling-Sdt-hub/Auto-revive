import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/CustomChecked.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/custom_linear_indicator.dart';


class MechanicExperienceSkillScreen extends StatefulWidget {
  MechanicExperienceSkillScreen({super.key});
  @override
  State<MechanicExperienceSkillScreen> createState() => _MechanicExperienceSkillScreenState();
}
class _MechanicExperienceSkillScreenState extends State<MechanicExperienceSkillScreen> {

  final List<String> workSpaceOptions = ['In Shop', 'On site', 'Both'];

  // Dummy questions
  final List<String> skills = [
    'Diesel Engine Repair',
    'Gasoline Engine Repair',
    'Semi Truck Repair',
    'Trailer Repair',
    'RV Repair',
    'Hydraulic Systems',
    'Electrical Diagnostics',
    'Brake Systems',
    'Welding/Fabrication',
    'Computer Diagnostics',
  ];
  bool? validUSDOTNumber;
  // State
  List<String> selectedWorkSpaces = List.generate(10, (index) => 'In Shop');
  List<TextEditingController> experienceControllers = List.generate(10, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in experienceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: "Experience and Skill",
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
              CustomText(
                text: 'How many experience do you have in the following?',
                fontsize: 16.sp,
                maxline: 2,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 4.h),
              ///<<<=============>>> Work Apace and Experience <<<===============>>>
              Row (
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(text: 'Work Space',fontsize: 12.sp),
                  SizedBox(width: 42.w),
                  CustomText(text: 'Experience',fontsize: 12.sp),
                ],
              ),
              SizedBox(height: 8.h),
              /// ==============================>  Skill rows  =================================>
              Column(
                children:
                List.generate(skills.length, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// ===================================> Skill label ==============================>
                        SizedBox(
                          width: 100.w,
                          child: CustomText(
                            text: skills[index],
                            fontsize: 14.sp,
                            textAlign: TextAlign.start,
                          ),
                        ),

                        /// ===============================>  Work space dropdown ===============================>
                        Container(
                          width: 100.w,
                          height: 36.h,
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedWorkSpaces[index],
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
                              items: workSpaceOptions.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item, style: TextStyle(fontSize: 12.sp)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedWorkSpaces[index] = value!;
                                });
                              },
                            ),
                          ),
                        ),

                        /// =============================> Experience input ==================================>
                        Container(
                          width: 80.w,
                          height: 36.h,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: TextField(
                            controller: experienceControllers[index],
                            style: TextStyle(fontSize: 12.sp),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'e.g. 4 Year',
                              hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                              isCollapsed: true,
                              contentPadding: EdgeInsets.only(top: 8.h),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(height: 17.h),
              /// =================================> Certification ==============================>
              CustomText(text: 'Certification',fontsize: 16.sp),
              SizedBox(height: 14.sp),
              CustomText(text: 'Are you comfortable working on-site (roadside, fleet yards, job sites)?',
                textAlign: TextAlign.start,
                maxline: 2,
                fontsize: 16.sp,
              ),
              CustomChecked(
                selected: validUSDOTNumber,
                onChanged: (val) {
                  setState(() {
                    validUSDOTNumber = val;
                  });
                },
              ),



              SizedBox(height: 94.h),
              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              CustomButton(
                title: "Save and Next",
                onpress: () {
                  // Action after saving data and moving to next screen
                  context.pushNamed(AppRoutes.resetPasswordScreen);
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

