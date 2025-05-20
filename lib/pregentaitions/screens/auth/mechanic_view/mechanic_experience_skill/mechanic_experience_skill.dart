import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../controllers/mechanic_controller.dart';
import '../../../../../models/get_profile_model.dart';
import '../../../../widgets/certification_custom_checkbox_list.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_linear_indicator.dart';


class MechanicExperienceSkillScreen extends StatefulWidget {
  const MechanicExperienceSkillScreen({super.key});
  @override
  State<MechanicExperienceSkillScreen> createState() => _MechanicExperienceSkillScreenState();
}
class _MechanicExperienceSkillScreenState extends State<MechanicExperienceSkillScreen> {

  MechanicController mechanicController = Get.put(MechanicController());

  final Map<String, bool> certificationCheckbox = {
    'ASE': false,
    'OEM': false,
    'DOT': false,
    'Other:': false,
  };

  final List<String> workSpaceOptions = ['In Shop', 'On site', 'Both'];


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




  // @override
  // void initState() {
  //   mechanicController.getAllExperience();
  //   super.initState();
  // }

  @override
  void initState() {
    super.initState();
    mechanicController.getAllExperience();

    // Delay to ensure controller & context are fully ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routeData = GoRouterState.of(context).extra as Map;

      // 🔹 Load Certifications
      List<String> certs = List<String>.from(routeData['certifications'] ?? []);
      certificationCheckbox.updateAll((key, value) => certs.contains(key));

      // 🔹 Load Experiences (MUST BE List<Experience>)
      List<Experience> expList = List<Experience>.from(routeData['experiences'] ?? []);

      // Reset controllers based on incoming list length
      selectedWorkSpaces = List.generate(expList.length, (_) => 'In Shop');
      experienceControllers = List.generate(expList.length, (_) => TextEditingController());

      for (int i = 0; i < expList.length; i++) {
        final experience = expList[i];

        // Ensure exact match with workSpaceOptions
        selectedWorkSpaces[i] = workSpaceOptions.firstWhere(
              (element) => element.toLowerCase() == (experience.platform ?? 'in shop').toLowerCase(),
          orElse: () => 'In Shop',
        );

        experienceControllers[i].text = experience.time?.toString() ?? '';
      }
      setState(() {});
    });
  }


  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    Map routeData = GoRouterState.of(context).extra as Map;
    final bool isEdit = (GoRouterState.of(context).extra as Map)['isEdit'] ?? false;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
          title: "${routeData["title"]}"),
      // appBar: AppBar(
      //   forceMaterialTransparency: true,
      //   title: CustomText(
      //     text: "Experience and Skill",
      //     fontsize: 20.sp,
      //     fontWeight: FontWeight.w400,
      //     textAlign: TextAlign.start,
      //   ),
      // ),
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
                  progressValue: 0.2,
                ),
                SizedBox(height: 20.h),
                CustomText(
                  text: 'How many experience do you have in the following?',
                  fontsize: 16.sp,
                  maxline: 2,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4.h),
                ///<<<=============>>> Work Space and Experience <<<===============>>>
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
                Obx(() {
                  if (mechanicController.experience.isEmpty) {
                    return Center(
                      child: CustomText(text: 'No data available',fontsize: 16.sp,color: AppColors.textColor151515)
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mechanicController.experience.length,
                    itemBuilder: (context, index) {
                      var skillName = mechanicController.experience[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// ===================================> Skill label ==============================>
                            SizedBox(
                              width: 100.w,
                              child: CustomText(
                                text: "${skillName.name}",
                                fontsize: 14.sp,
                                textAlign: TextAlign.start,
                              ),
                            ),

                            /// ===============================> Work space dropdown ===============================>
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
                                  value: selectedWorkSpaces.length > index
                                      ? selectedWorkSpaces[index]
                                      : workSpaceOptions[0],
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                                  items: workSpaceOptions.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item, style: TextStyle(fontSize: 12.sp,color: AppColors.textColor151515)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      if (selectedWorkSpaces.length > index) {
                                        selectedWorkSpaces[index] = value!;
                                      }
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
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: experienceControllers.length > index
                                    ? experienceControllers[index]
                                    : TextEditingController(),
                                style: TextStyle(fontSize: 12.sp,color: AppColors.textColor151515),

                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'e.g. 4 Year',
                                  hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.only(top: 8.h),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter field';
                                  }
                                  return null;
                                },
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                  );

                }),

                SizedBox(height: 17.h),
                /// =================================> Certification ==============================>
                CustomText(text: 'Certification',fontsize: 16.sp),
                SizedBox(height: 14.sp),
                ExperienceCustomCheckboxList(
                  items: certificationCheckbox,
                ),
                /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
                SizedBox(height: 50.h),

                Obx(() => CustomButton(
                  loading: mechanicController.experienceCertificationsLoading.value,
                  title: isEdit ? "Edit" : "Save and Next",
                  onpress: () async {
                    if (fromKey.currentState!.validate()) {
                      final experienceList = <Map<String, dynamic>>[];

                      for (int i = 0; i < mechanicController.experience.length; i++) {
                        final experienceId = mechanicController.experience[i].id;
                        final platform = selectedWorkSpaces.length > i
                            ? selectedWorkSpaces[i].toLowerCase()
                            : 'in shop';
                        final time = int.tryParse(experienceControllers[i].text.trim()) ?? 0;

                        if (time > 0) {
                          experienceList.add({
                            "experienceId": experienceId,
                            "platform": platform,
                            "time": time,
                          });
                        }
                      }

                      final selectedCerts = certificationCheckbox.entries
                          .where((e) => e.value)
                          .map((e) => e.key)
                          .toList();

                      final success = await mechanicController.experienceCertifications(
                        experiences: experienceList,
                        certifications: selectedCerts,
                        context: context,
                      );

                      if (success) {
                        isEdit
                            ? context.pop(true)
                            : context.pushNamed(AppRoutes.mechanicToolsEquipmentScreen);
                      }
                    }
                  },
                )),

                // Obx(()=>
                //    CustomButton(
                //      loading: mechanicController.experienceCertificationsLoading.value,
                //     title: "Save and Next",
                //        onpress: () async {
                //          if (fromKey.currentState!.validate()) {
                //            final experienceList = <Map<String, dynamic>>[];
                //            for (int i = 0; i < mechanicController.experience.length; i++) {
                //              final experienceId = mechanicController.experience[i].id;
                //              final workspace = selectedWorkSpaces.length > i ? selectedWorkSpaces[i].toLowerCase() : 'in shop';
                //              final timeText = experienceControllers[i].text.trim();
                //              final time = int.tryParse(timeText) ?? 0;
                //              if (time > 0) {
                //                experienceList.add({
                //                  "experienceId": experienceId,
                //                  "platform": workspace,
                //                  "time": time,
                //                });
                //              }
                //            }
                //            final selectedCertifications = certificationCheckbox.entries
                //                .where((entry) => entry.value)
                //                .map((entry) => entry.key)
                //                .toList();
                //            final success = await mechanicController.experienceCertifications(
                //              experiences: experienceList,
                //              certifications: selectedCertifications,
                //              context: context,
                //            );
                //            if (success) {
                //              context.pushNamed(AppRoutes.mechanicToolsEquipmentScreen);
                //            }
                //          }
                //        }
                //    ),),



                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }




}

