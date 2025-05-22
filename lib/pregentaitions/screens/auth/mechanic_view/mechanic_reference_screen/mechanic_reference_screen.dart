import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../controllers/mechanic_controller.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../../helpers/toast_message_helper.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_checkbox_list.dart';
import '../../../../widgets/custom_linear_indicator.dart';

class MechanicReferenceScreen extends StatefulWidget {
  MechanicReferenceScreen({super.key});

  @override
  State<MechanicReferenceScreen> createState() => _MechanicReferenceScreenState();
}

class _MechanicReferenceScreenState extends State<MechanicReferenceScreen> {


  MechanicController mechanicController = Get.put(MechanicController());
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  List<ReferenceFormData> referenceList = [ReferenceFormData()];

  void addReference() {
    setState(() {
      referenceList.add(ReferenceFormData());
    });
  }


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final routeData = GoRouterState.of(context).extra as Map;
      final extra = GoRouterState.of(context).extra;
      final Map routeData = extra is Map ? extra : {};
      final isEdit = routeData['isEdit'] ?? false;
      final data = routeData['data'];

      if (isEdit && data != null) {
        final ref = ReferenceFormData();

        ref.nameCtrl.text = data.name ?? '';
        ref.phoneNoCtrl.text = data.phone ?? '';
        ref.relationshipMap.updateAll((key, value) => false);
        if (data.relation != null && ref.relationshipMap.containsKey(data.relation)) {
          ref.relationshipMap[data.relation!] = true;
        }

        referenceList = [ref];
        setState(() {});
      }
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
          text: "Reference",
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
                              maxLength: 11,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter phone number';
                                } else if (value.length < 11) {
                                  return 'Phone number must be 11 digits';
                                } else if (value.length > 11) {
                                  return 'Phone number cannot exceed 11 digits';
                                }
                                return null;
                              },
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
                        const Icon(Icons.add, color: AppColors.primaryColor),
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
                SizedBox(height: 20.h),

                Obx(() => Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        loading: mechanicController.referenceLoading.value,
                        title: isEdit ? "Edit" : "Save and Next",
                        onpress: () async {
                          if (fromKey.currentState!.validate()) {
                            List<Map<String, String>> referencesData = [];

                            for (var ref in referenceList) {
                              String? selectedRelation = ref.relationshipMap.entries
                                  .firstWhere((e) => e.value, orElse: () => MapEntry('', false))
                                  .key;

                              if (selectedRelation.isEmpty) {
                                ToastMessageHelper.showToastMessage("You must select at least one Relationship!", title: 'Attention');
                                return;
                              }

                              referencesData.add({
                                'name': ref.nameCtrl.text,
                                'phone': ref.phoneNoCtrl.text,
                                'relation': selectedRelation,
                              });
                            }

                            final success = await mechanicController.referencesList(
                              references: referencesData,
                              context: context,
                            );
                            if (success) {
                              if (isEdit) {
                                context.pop(true);
                              } else {
                                context.pushNamed(AppRoutes.mechanicAdditionalInformationScreen);
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ],
                )),

                SizedBox(height: 70.h),

                // Obx(()=>
                //    CustomButton(
                //      loading: mechanicController.referenceLoading.value,
                //     title: "Save and Next",
                //      onpress: () {
                //        if (fromKey.currentState!.validate()) {
                //          List<Map<String, String>> referencesData = [];
                //          for (var ref in referenceList) {
                //            String? selectedRelation = ref.relationshipMap.entries
                //                .firstWhere((element) => element.value, orElse: () => MapEntry('', false))
                //                .key;
                //
                //            if (selectedRelation.isEmpty) {
                //              ToastMessageHelper.showToastMessage("Please select relation for all references");
                //              return;
                //            }
                //
                //            referencesData.add({
                //              'name': ref.nameCtrl.text,
                //              'phone': ref.phoneNoCtrl.text,
                //              'relation': selectedRelation,
                //            });
                //          }
                //
                //          mechanicController.referencesList(
                //            references: referencesData,
                //            context: context,
                //          );
                //        }
                //      },
                //    ),),
                SizedBox(height: 70.h),
              ],
            ),
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
