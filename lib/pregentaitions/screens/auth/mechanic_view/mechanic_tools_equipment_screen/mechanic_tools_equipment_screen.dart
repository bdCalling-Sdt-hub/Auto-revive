import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/CustomChecked.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_loader.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import '../../../../../controllers/mechanic_controller.dart';
import '../../../../widgets/custom_checkbox_list.dart';
import '../../../../widgets/custom_linear_indicator.dart';
import '../../../../widgets/custom_text_field.dart';


class MechanicToolsEquipmentScreen extends StatefulWidget {
  MechanicToolsEquipmentScreen({super.key});
  @override
  State<MechanicToolsEquipmentScreen> createState() => _MechanicToolsEquipmentScreenState();
}
class _MechanicToolsEquipmentScreenState extends State<MechanicToolsEquipmentScreen> {

  MechanicController mechanicController = Get.put(MechanicController());
  final TextEditingController additionalToolsCtrl = TextEditingController();


  bool? validUSDOTNumber;


  @override
  void initState() {
   mechanicController.getAllTools();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: "Tools and Equipment",
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
                progressValue: 0.3,
              ),
              SizedBox(height: 29.h),
              ///<<<=============>>> CHECKED <<<===============>>>
              CustomText(
                text: 'Do you have own tools?',
                fontsize: 16.sp,
                textAlign: TextAlign.left,
              ),
              CustomChecked(
                selected: validUSDOTNumber,
                onChanged: (val) {
                  setState(() {
                    validUSDOTNumber = val;
                  });
                },
              ),

              /// <<<=============>>> Tools Group List <<<===============>>>
              Obx(() {
                if (mechanicController.toolsLoading.value) {
                  return const Center(child: CustomLoader());
                } else if (mechanicController.tools.isEmpty) {
                  return Center(child: CustomText(text: "No Tools Found", fontsize: 16.sp));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mechanicController.tools.length,
                    itemBuilder: (context, groupIndex) {
                      var group = mechanicController.tools[groupIndex];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: group.groupName ?? "No Group Name",
                            fontsize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 10.h),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: group.tools.length,
                            itemBuilder: (context, toolIndex) {
                              var tool = group.tools[toolIndex];
                              return CustomCheckboxList(
                                items: {
                                  tool.name ?? "Unnamed Tool": false,
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],
                      );
                    },
                  );
                }
              }),




              SizedBox(height: 20.h),
              ///<<<=============>>> Additional Tools <<<===============>>>
              CustomText(
                  text: "List any additional  tools you own",fontsize: 16.sp),
              SizedBox(height: 8.h),
              CustomTextField(
                  controller: additionalToolsCtrl,
                  hintText: "Additional Tools",


              ),
              SizedBox(height: 87.h),
              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              CustomButton(
                title: "Save and Next",
                onpress: () {
                  context.pushNamed(AppRoutes.mechanicEmploymentHistoryScreen);
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

