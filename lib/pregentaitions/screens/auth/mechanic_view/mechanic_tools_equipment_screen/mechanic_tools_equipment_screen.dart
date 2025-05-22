import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/CustomChecked.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_loader.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../controllers/mechanic_controller.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../helpers/toast_message_helper.dart';
import '../../../../widgets/custom_linear_indicator.dart';
import '../../../../widgets/equipment_check_box_list.dart';


class MechanicToolsEquipmentScreen extends StatefulWidget {
  const MechanicToolsEquipmentScreen({super.key});
  @override
  State<MechanicToolsEquipmentScreen> createState() => _MechanicToolsEquipmentScreenState();
}
class _MechanicToolsEquipmentScreenState extends State<MechanicToolsEquipmentScreen> {

  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  MechanicController mechanicController = Get.put(MechanicController());

  final TextEditingController additionalToolsCtrl = TextEditingController();


  bool? validUSDOTNumber;
  final  List<String> customTools = [];

  // @override
  // void initState() {
  //  mechanicController.getAllTools();
  //   super.initState();
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final routeData = GoRouterState.of(context).extra as Map;
      final extra = GoRouterState.of(context).extra;
      final Map routeData = extra is Map ? extra : {};

      final bool isEdit = routeData['isEdit'] ?? false;
      final toolsGroup = routeData['toolsGroup'];
      final custom = routeData['toolsCustom'];
      if (mechanicController.tools.isEmpty) {
        await mechanicController.getAllTools();
      }
      if (isEdit && toolsGroup != null) {
        final selectedNames = <String>{};
        for (var entry in toolsGroup.groups.entries) {
          selectedNames.addAll(entry.value);
        }

        for (var group in mechanicController.tools) {
          for (var tool in group.tools) {

            if (tool.name != null && selectedNames.contains(tool.name)) {
              tool.isSelected = true;
            } else {
              tool.isSelected = false;
            }
          }
        }
      }


      if (custom != null) {
        customTools.clear();
        customTools.addAll(List<String>.from(custom.where((e) => e != null && e.toString().isNotEmpty)));
      }
      setState(() {});
    });
  }






  @override
  Widget build(BuildContext context) {
    // Map routeData = GoRouterState.of(context).extra as Map;
    // final bool isEdit = (GoRouterState.of(context).extra as Map)['isEdit'] ?? false;
    final extra = GoRouterState.of(context).extra;
    final Map routeData = extra is Map ? extra : {};
    final bool isEdit = routeData['isEdit'] ?? false;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: CustomAppBar(
      //     title: "${routeData["title"]}"),
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
          child: Form(
            key: fromKey,
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
                                return EquipmentCustomCheckboxList(
                                  items: {
                                    tool.name ?? "Unnamed Tool": tool.isSelected ?? false,
                                  },
                                  onChanged: (key, value) {
                                    setState(() {
                                      tool.isSelected = value;
                                    });
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
                  text: "List any additional tools you own",
                  fontsize: 16.sp,
                ),
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: customTools.map((tool) {
                    return Chip(
                      label: Text(tool),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        setState(() {
                          customTools.remove(tool);
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: 344,
                  height: 46,
                  padding:  EdgeInsets.symmetric(horizontal: 15.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 0.5,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: additionalToolsCtrl,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.r),
                        hintText: "Additional Tools",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add, color: Colors.blue),
                          onPressed: () {
                            String newTool = additionalToolsCtrl.text.trim();
                            if (newTool.isEmpty) return;
                            if (!customTools.contains(newTool)) {
                              setState(() {
                                customTools.add(newTool);
                              });
                            }
                            additionalToolsCtrl.clear();
                          },
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),


                SizedBox(height: 85.h),
                /// ================================>>>>  Save and Next button    <<<<<<=============================>>>


                Obx(() => CustomButton(
                  loading: mechanicController.mechanicToolsLoading.value,
                  title: isEdit ? "Edit" : "Save and Next",
                  onpress: () {
                    if (fromKey.currentState!.validate()) {

                      List<String> selectedToolIds = [];
                      mechanicController.tools.forEach((group) {
                        group.tools.forEach((tool) {
                          if (tool.isSelected == true) {
                            selectedToolIds.add(tool.id!);
                          }
                        });
                      });
                      if (selectedToolIds.isEmpty) {
                        ToastMessageHelper.showToastMessage('You must select at least one tools!', title: 'Attention');
                        return;
                      }
                      if (customTools.isEmpty) {
                        ToastMessageHelper.showToastMessage('You must enter at least one custom tools!', title: 'Attention');
                        return;
                      }
                      mechanicController.mechanicTools(
                        tools: selectedToolIds,
                        toolsCustom: customTools,
                        context: context,
                      ).then((success) {
                        if (success) {
                          isEdit
                              ? context.pop(true)
                              : context.pushNamed(AppRoutes.mechanicEmploymentHistoryScreen);
                        }
                      });
                    }
                  },
                )),

                // Obx(() => CustomButton(
                //   loading: mechanicController.mechanicToolsLoading.value,
                //   title: "Save and Next",
                //     onpress: () {
                //       if (fromKey.currentState!.validate()) {
                //         List<String> selectedToolIds = [];
                //         mechanicController.tools.forEach((group) {
                //           group.tools.forEach((tool) {
                //             if (tool.isSelected == true) {
                //               selectedToolIds.add(tool.id!);
                //             }
                //           });
                //         });
                //         mechanicController.mechanicTools(
                //           tools: selectedToolIds,
                //           toolsCustom: customTools,
                //           context: context,
                //         ).then((success) {
                //           if (success) {
                //             context.pushNamed(AppRoutes.mechanicEmploymentHistoryScreen);
                //           }
                //         });
                //       }
                //     }
                // )),
                SizedBox(height: 70.h),
              ],
            ),
          ),
        ),
      ),
    );
  }




}

