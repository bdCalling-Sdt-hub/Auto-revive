import 'package:autorevive/pregentaitions/screens/auth/mechanic_view/mechanic_personal_screen/mechanic_personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../controllers/mechanic_controller.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../models/get_profile_model.dart';
import '../../../../../services/api_constants.dart';
import '../../../../widgets/cachanetwork_image.dart';
import '../../../../widgets/custom_upload_button.dart';
import 'package:intl/intl.dart';


class MechanicProfileInformationScreen extends StatefulWidget {
   MechanicProfileInformationScreen({super.key});

  @override
  State<MechanicProfileInformationScreen> createState() => _MechanicProfileInformationScreenState();
}

class _MechanicProfileInformationScreenState extends State<MechanicProfileInformationScreen> {

  MechanicController mechanicController = Get.put(MechanicController());





  @override
  void initState() {
    mechanicController.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final toolsMap = mechanicController.profile.value.toolsGroup != null
        ? toolsGroupToMap(mechanicController.profile.value.toolsGroup!)
        : {};
    return CustomScaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CustomText(
          textAlign: TextAlign.start,
          text: "Profile Information",
          fontsize: 20.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Obx(()=>

            Column(
              children: [
                /// ==================================> Profile ====================================>
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl: "${ApiConstants.imageBaseUrl}/${mechanicController.profile.value.profileImage}",
                      height: 128.h,
                      width: 128.w,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                text: mechanicController.profile.value.name ?? 'N/A',
                                fontsize: 25.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor151515,
                              ),
                              SizedBox(width: 40.w),

                              GestureDetector(
                                onTap: () {
                                  // context.pushNamed(AppRoutes.mechanicProfileInformationScreen,);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MechanicPersonalInformationScreen()));
                                },
                                child: Assets.icons.editIcon.svg(),
                              ),

                            ],
                          ),
                          SizedBox(height: 4.h),
                          CustomText(text:
                            mechanicController.profile.value.role ?? 'N/A',
                            fontsize: 15.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textColor151515,
                          ),
                          SizedBox(height: 2.h),
                          CustomText(
                           text:  '${mechanicController.profile.value.phone ?? 'N/A'}  |  ${mechanicController.profile.value.email ?? 'N/A'}',
                            fontsize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor151515,
                          ),
                          SizedBox(height: 2.h),
                          CustomText(text:
                            mechanicController.profile.value.address ?? 'N/A',
                           fontsize: 12.sp,
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            text: 'Have:',
                            fontsize: 14.sp,
                            color: AppColors.textColor151515,
                          ),
                          SizedBox(height: 4.h),
                          // Have section below address
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (mechanicController.profile.value.haveLicense == true)
                                _buildTag('License'),
                              if (mechanicController.profile.value.haveCdl == true)
                                ...[
                                  SizedBox(width: 10.w),
                                  _buildTag('CDL'),
                                ],
                              if (mechanicController.profile.value.haveLicense != true &&
                                  mechanicController.profile.value.haveCdl != true)
                                _buildTag('N/A'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18.h),
                CustomContainer(
                  paddingAll: 16.h,
                  radiusAll: 8.r,
                  bordersColor: AppColors.borderColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 20.w,
                        runSpacing: 15.h,
                        children: [

                          /// ============================================> Certificate Section =================================>

                          if (mechanicController.profile.value.certifications != null &&
                              mechanicController.profile.value.certifications!.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Certificate:',
                                  fontsize: 16.sp,
                                  color: AppColors.textColor151515,
                                ),
                                SizedBox(height: 13.h),
                                Wrap(
                                  spacing: 10.w,
                                  children: mechanicController.profile.value.certifications!
                                      .map((cert) => _buildTag(cert))
                                      .toList(),
                                ),
                              ],
                            ),

                        ],
                      ),
                      SizedBox(height: 10.h),
                      CustomText(
                          text:
                          'Comfortable working on-site (roadside, fleet yards, job sites)'),
                      SizedBox(height: 15.h),
                      /// ==================================> Experience and More ====================================>
                      CustomText(
                        text: 'Experience and More',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10.h),
                      /// ======================================> ListView to display the experience items =============================>
                      SizedBox(
                        height: 400.h,
                        child: (mechanicController.profile.value.experiences == null ||
                            mechanicController.profile.value.experiences!.isEmpty)
                            ? Center(
                          child: Text(
                            "No experience data available",
                            style: TextStyle(fontSize: 14.sp, color: Colors.black),
                          ),
                        )
                            : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: mechanicController.profile.value.experiences!.length,
                          itemBuilder: (context, index) {
                            var experience = mechanicController.profile.value.experiences![index];
                            String title = experience.experienceId?.name ?? 'N/A';
                            String location = experience.platform ?? 'N/A';
                            String duration = '${experience.time} year';
                            return _buildExperienceRow(title, location, duration);
                          },
                        ),
                      ),

                      /// ==================================> Tools and Equipment ====================================>
                      CustomText(text: 'Tools and Equipment',fontsize: 16.sp,color: AppColors.textColor151515,),
                      SizedBox(height: 13.h),
                      ListView.builder(
                        itemCount: toolsMap.keys.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, groupIndex) {
                          final groupName = toolsMap.keys.elementAt(groupIndex);
                          final tools = toolsMap[groupName]!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: groupName,
                                fontWeight: FontWeight.bold,
                                fontsize: 16.sp,
                              ),
                              ListView.builder(
                                itemCount: toolsMap.keys.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, groupIndex) {
                                  final groupName = toolsMap.keys.elementAt(groupIndex);
                                  final tools = toolsMap[groupName]!;

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: groupName,
                                        fontWeight: FontWeight.bold,
                                        fontsize: 16.sp,
                                      ),
                                      ListView.builder(
                                        itemCount: tools.length,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final tool = tools[index];
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 8.h),
                                            child: CustomText(
                                              textAlign: TextAlign.start,
                                              text: '${tool.name ?? 'N/A'}\n${groupValues.reverse[tool.group] ?? 'N/A'}',
                                              fontsize: 10.sp,
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 12.h),
                                    ],
                                  );
                                },
                              ),

                              SizedBox(height: 12.h),
                            ],
                          );
                        },
                      ),


                      SizedBox(height: 15.h),
                      // /// ==================================> Sockets & Ratchets ====================================>
                      // CustomText(
                      //   text: 'Sockets & Ratchets...',
                      //   fontsize: 16.sp,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      // CustomText(
                      //   textAlign: TextAlign.start,
                      //   text:
                      //   "1/4\" Drive Sockets (Standard & Deep)."
                      //       '\n3/8\" Drive Sockets (Standard & Deep).'
                      //       '\n1/2\" Drive Sockets (Standard & Deep).'
                      //       '\n3/4\" Drive Sockets (Standard & Deep).'
                      //       '\n1\" Drive Sockets (Standard & Deep).'
                      //       '\nUniversal Joints & Extensions (All Drive Sizes).'
                      //       '\nTorque Wrench (1/4\", 3/8\", 1/2\", 3/4\", 1\").',
                      //   fontsize: 10.sp,
                      // ),
                      SizedBox(height: 15.h),
                      /// ==================================> Employment History ====================================>
                      ListView.builder(
                        itemCount: mechanicController.profile.value.employmentHistories?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final history = mechanicController.profile.value.employmentHistories![index];

                          final fromDate = DateFormat('dd MMM yyyy').format(DateTime.parse('${history.durationFrom}'));
                          final toDate = DateFormat('dd MMM yyyy').format(DateTime.parse('${history.durationTo}'));

                          return Padding(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  textAlign: TextAlign.start,
                                  text: history.companyName ?? 'N/A',
                                  fontWeight: FontWeight.bold,
                                  fontsize: 18.sp,
                                ),
                                CustomText(
                                  textAlign: TextAlign.start,
                                  text: '${history.jobName}',
                                  fontsize: 10.sp,
                                ),
                                CustomText(
                                  textAlign: TextAlign.start,
                                  text: history.supervisorsName ?? 'N/A',
                                  fontsize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  textAlign: TextAlign.start,
                                  text: '${history.supervisorsContact ?? 'N/A'}'
                                      '\n$fromDate to $toDate'
                                      '\n${history.reason}',
                                  fontsize: 10.sp,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15.h),
                      /// ==================================> Reference =============================================>
                      ListView.builder(
                        itemCount: mechanicController.profile.value.references?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final reference = mechanicController.profile.value.references![index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Reference ${index + 1}',
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  textAlign: TextAlign.start,
                                  text: reference.name ?? 'N/A',
                                  fontsize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  textAlign: TextAlign.start,
                                  text: '${reference.phone ?? 'N/A'}\n${reference.relation ?? 'N/A'}',
                                  fontsize: 10.sp,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15.h),
                      CustomText(
                        textAlign: TextAlign.start,
                        maxline: 2,
                        text: 'Why do I want to work at On-Site Fleet Services?',
                        color: AppColors.textColor151515,fontsize: 18.sp,),
                      SizedBox(height: 10.h),
                      CustomText(
                        textAlign: TextAlign.start,
                          maxline: 10,
                          text: mechanicController.profile.value.whyOnSite ?? 'N/A',
                          fontsize: 10.sp,
                          color: AppColors.textColor151515),
                      SizedBox(height: 24.h),

                      /// ================================> Pdf Button ==============================================>

                      CustomUploadButton(
                        title: getFileName(mechanicController.profile.value.resume),
                        onTap: () {
                          // Handle resume tap
                        },
                      ),
                      SizedBox(height: 12.h),
                      CustomUploadButton(
                        title: getFileName(mechanicController.profile.value.certificate),
                        onTap: () {
                          // Handle certificate tap
                        },
                      ),

                      /// ==============================================> Go to Home Button ============================================>

                      SizedBox(height: 16.h),
                      CustomButton(
                        title: "Go To Home",
                        onpress: () {
                          context.pushNamed(AppRoutes.mechanicBottomNavBar);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Map<String, List<Tool>> toolsGroupToMap(ToolsGroup toolsGroup) {
    final Map<String, List<Tool>> groupedTools = {};

    if (toolsGroup.basicHand != null && toolsGroup.basicHand!.isNotEmpty) {
      groupedTools["Basic hand"] = toolsGroup.basicHand!;
    }

    if (toolsGroup.group2 != null && toolsGroup.group2!.isNotEmpty) {
      groupedTools["Group 2"] = toolsGroup.group2!;
    }

    if (toolsGroup.group3 != null && toolsGroup.group3!.isNotEmpty) {
      groupedTools["Group 3"] = toolsGroup.group3!;
    }

    return groupedTools;
  }


  String getFileName(String? path) {
    if (path == null || path.trim().isEmpty) return 'Not uploaded';
    path = path.replaceAll('\\', '/');
    return path.split('/').last;
  }
  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.borderColorE6E6FF,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: CustomText(
        text: text,
        fontsize: 12.sp,
        color: AppColors.textColor151515,
      ),
    );
  }


  Widget _buildExperienceRow(String title, String location, String duration) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(fontSize: 14.sp, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              location,
              style: TextStyle(fontSize: 13.sp, color: AppColors.textColor151515),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              duration,
              style: TextStyle(fontSize: 13.sp, color: Colors.black),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

}
