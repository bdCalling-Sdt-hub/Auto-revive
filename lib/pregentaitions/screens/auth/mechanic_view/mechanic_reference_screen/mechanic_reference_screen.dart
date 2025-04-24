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

class MechanicReferenceScreen extends StatefulWidget {
  MechanicReferenceScreen({super.key});

  @override
  State<MechanicReferenceScreen> createState() => _MechanicReferenceScreenState();
}

class _MechanicReferenceScreenState extends State<MechanicReferenceScreen> {

  List<ReferenceFormData> referenceList = [ReferenceFormData()];

  void addReference() {
    setState(() {
      referenceList.add(ReferenceFormData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: "Reference",
          fontsize: 20.sp,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.start,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8.h),
              const CustomLinearIndicator(progressValue: 0.6),
              SizedBox(height: 20.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: referenceList.length,
                itemBuilder: (context, index) {
                  final ref = referenceList[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CustomText(
                              text: 'Reference ${index + 1}',
                              fontsize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          CustomText(
                            text: "Name:",
                            fontsize: 14.sp,
                            color: AppColors.textColor151515,
                          ),
                          SizedBox(height: 8.h),
                          CustomTextField(
                            controller: ref.nameCtrl,
                            hintText: "Name",
                          ),
                          CustomText(
                            text: "Phone No:",
                            fontsize: 14.sp,
                            color: AppColors.textColor151515,
                          ),
                          SizedBox(height: 8.h),
                          CustomTextField(
                            controller: ref.phoneNoCtrl,
                            hintText: "Phone No",
                            keyboardType: TextInputType.number,
                            readOnly: false,
                          ),
                          CustomText(
                            text: "Relationship:",
                            fontsize: 14.sp,
                            color: AppColors.textColor151515,
                          ),
                          CustomCheckboxList(items: ref.relationshipMap),
                        ],
                      ),
                    ),
                  );
                },
              ),


              /// ===================================> Add More Button  ========================================>
              GestureDetector(
                onTap: addReference,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.add, color: AppColors.primaryColor),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: "Add more",
                        fontsize: 14.sp,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// ===================================>  Save and Next ==============================>
              CustomButton(
                title: "Save and Next",
                onpress: () {
                  context.pushNamed(AppRoutes.mechanicAdditionalInformationScreen);
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

class ReferenceFormData {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();

  final Map<String, bool> relationshipMap = {
    'Supervisor': false,
    'Co-worker': false,
    'Other': false,
  };
}
