import 'package:autorevive/controllers/towTrack/registration_tow_track_controller.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../services/api_constants.dart';
import '../../../../../widgets/cachanetwork_image.dart';
import 'package:intl/intl.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {

  TowTrackController towTrackController = Get.put(TowTrackController());


  @override
  void initState() {
    towTrackController.getTowTrackProfile();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          centerTitle: false,
          title: CustomText(
            textAlign: TextAlign.start,
            text: "Profile Details",
            fontsize: 20.sp,
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                /// =================================> ProfileImage ================================>
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomNetworkImage(
                    boxShape: BoxShape.circle,
                    imageUrl:
                    towTrackController.trackProfile.value.profileImage == null ||   towTrackController.trackProfile.value.profileImage == "" ?
                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" :
                    "${ApiConstants.imageBaseUrl}/${ towTrackController.trackProfile.value.profileImage}",
                    height: 128.h,
                    width: 128.w,
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                height: 1.4),
                            text: towTrackController.trackProfile.value.name ?? 'N/A',
                            children: [
                          // TextSpan(
                          //     style: TextStyle(
                          //         color: AppColors.primaryColor,
                          //         fontSize: 20.sp),
                          //     text: '(\$25)'),
                          TextSpan(
                              style: TextStyle(fontSize: 10.sp),
                              text: '\n ${towTrackController.trackProfile.value.role ?? 'N/A'} '
                                  '\n ${towTrackController.trackProfile.value.phone ?? 'N/A'}     ||   ${towTrackController.trackProfile.value.email ?? 'N/A'} '
                                  '\n ${towTrackController.trackProfile.value.address ?? 'N/A'}'),
                        ])),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              /// ==============================================> Basic Info ==================================>
              CustomContainer(
                paddingAll: 16.h,
                radiusAll: 8.r,
                bordersColor: AppColors.borderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: CustomText(
                      text: towTrackController.trackProfile.value.companyName ?? 'N/A',
                      fontsize: 18.sp,
                    )),
                    Center(
                        child: CustomText(
                      text: 'Owner: ${towTrackController.trackProfile.value.companyOwner ?? 'N/A'}',
                      fontsize: 13.sp,
                    )),
                    CustomText(
                      bottom: 20.h,
                      maxline: 10,
                      text:
                          'Contact: ${towTrackController.trackProfile.value.companyPhone ?? 'N/A'} | ${towTrackController.trackProfile.value.companyEmail ?? 'N/A'} | ${towTrackController.trackProfile.value.website ?? 'N/A'} '
                          '\nYears of business: ${towTrackController.trackProfile.value.yearsInBusiness ?? 'N/A'} | Number of tow trucks: ${towTrackController.trackProfile.value.totalTows ?? 'N/A'} '
                          '\nEIN number: ${towTrackController.trackProfile.value.einNo ?? 'N/A'}',
                      fontsize: 10.sp,
                    ),
                    const Divider(
                      color: AppColors.borderColor,
                    ),

                    /// ============================>  Licensing and Compliance =========================>
                    CustomText(
                      text: 'Licensing and Compliance',
                      fontsize: 20.sp,
                    ),
                    CustomText(
                        maxline: 2,
                        textAlign: TextAlign.start,
                        text: 'Have a valid US-DOT number'
                            '\nUS-DOT number: ${towTrackController.trackProfile.value.usDotNo ?? 'N/A'}'),
                    CustomUploadButton(
                      title: 'US-DOT number.pdf',
                      // getFileName(towTrackController.trackProfile.value.usDotFile),
                      onTap: () {

                      },
                      showUploadIcon: false,
                    ),

                    /// ++++++++++++++++ 2st Step +++++++++++++++++++++++
                    CustomText(
                        maxline: 10,
                        top: 16.h,
                        textAlign: TextAlign.start,
                        text: 'Have commercial insurance coverage '
                            '\nPolicy Number : ${towTrackController.trackProfile.value.policyNo ?? 'N/A'} '
                            '\nCoverage Limits : ${towTrackController.trackProfile.value.policyLimit ?? 'N/A'}'),
                    CustomUploadButton(
                      title: 'Insurance.pdf',
                      // towTrackController.trackProfile.value.policyFile ?? 'N/A',
                      onTap: () {

                      },
                      showUploadIcon: false,
                    ),

                    /// ++++++++++++++++ 3th Step +++++++++++++++++++++++
                    CustomText(
                        maxline: 10,
                        top: 16.h,
                        textAlign: TextAlign.start,
                        text: 'Have a valid Motor Carrier (MC) number. '
                            '\nMC Number : ${towTrackController.trackProfile.value.mcNo ?? 'N/A'} '
                            '\nCoverage Limits : ${towTrackController.trackProfile.value.policyLimit ?? 'N/A'}'),
                    CustomUploadButton(
                      title: 'Mc.pdf',
                      // towTrackController.trackProfile.value.mcFile ?? 'N/A',
                      onTap: () {

                      },
                      showUploadIcon: false,
                    ),

                    const Divider(
                      color: AppColors.borderColor,
                    ),

                    /// ++++++++++++++++ 4th Step +++++++++++++++++++++++
                    CustomText(
                      text: 'Vehicle and Equipment',
                      fontsize: 20.sp,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: towTrackController.trackProfile.value.vehicles?.length,
                      itemBuilder: (context, index) {
                        final vehicle = towTrackController.trackProfile.value.vehicles?[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                maxline: 10,
                                textAlign: TextAlign.start,
                                text: 'Making Year: ${vehicle?.year ?? 'N/A'} '
                                    '\nBrand: ${vehicle?.brand ?? 'N/A'} '
                                    '\nModel: ${vehicle?.modelNo ?? 'N/A'} '
                                    '\nGVWR: ${vehicle?.gvwr ?? 'N/A'} '
                                    '\nType of tow truck: ${vehicle?.type ?? 'N/A'}',
                              ),
                              SizedBox(height: 10.h),
                              CustomUploadButton(
                                title: 'towTrack.Mp4',
                                // '${vehicle?.video}',
                                onTap: () {},
                                showUploadIcon: false,
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const Divider(
                      color: AppColors.borderColor,
                    ),

                    /// ++++++++++++++++ 5th Step +++++++++++++++++++++++

                    CustomText(
                      text: 'Service and Coverage Area',
                      fontsize: 20.sp,
                    ),
                    CustomText(
                      text: 'Types of towing services do we offer.',
                      fontsize: 16.sp,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: towTrackController.trackProfile.value.services?.length,
                      itemBuilder: (context, index) {
                        final services = towTrackController.trackProfile.value.services?[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: '${services}',
                            fontsize: 10.sp,
                          ),
                        );
                      },
                    ),

                    CustomText(
                      maxline: 10,
                      textAlign: TextAlign.start,
                      text: 'Primary service area: ${towTrackController.trackProfile.value.primaryCity ?? 'N/A'} '
                          '\nRegions Covered: ${towTrackController.trackProfile.value.regionsCovered ?? 'N/A'}'
                          '\n${towTrackController.trackProfile.value.emergency247 ?? 'N/A'}'
                          '\nAverage ETA for service calls : ${towTrackController.trackProfile.value.eta ?? 'N/A'}',
                      fontsize: 16.sp,
                    ),

                    /// ++++++++++++++++ 6th Step +++++++++++++++++++++++

                    const Divider(
                      color: AppColors.borderColor,
                    ),

                    CustomText(
                      textAlign: TextAlign.start,
                      maxline: 2,
                      text: 'Business requirements and agreements',
                      fontsize: 20.sp,
                    ),
                    CustomText(
                      maxline: 5,
                      textAlign: TextAlign.start,
                      text:
                          'By applying to work with Fix It LLC, you agree to the following.',
                      fontsize: 16.sp,
                    ),
                    CustomText(
                      maxline: 20,
                      textAlign: TextAlign.start,
                      text:
                          'Maintain active DOT registration & insurance coverage at all times. '
                          '\nAdhere to all local, state, and federal regulations for towing \noperations.'
                          '\n Provide timely and professional service for Fix It LLC customers.'
                          '\nMaintain clean and well-maintained tow trucks and equipment.'
                          '\nCommunicate accurate ETAs and service updates.'
                          '\nSubmit a live walk-around video showing that all trucks meet \noperational standards.',
                      fontsize: 10.sp,
                    ),
                    CustomText(
                      maxline: 5,
                      textAlign: TextAlign.start,
                      text: 'Authorized or Representative name : ${towTrackController.trackProfile.value.authName ??'N/A'}',
                      fontsize: 16.sp,
                    ),
                    CustomText(
                      maxline: 5,
                      textAlign: TextAlign.start,
                      text:
                          'Authorized or Representative title : ${towTrackController.trackProfile.value.authTitle ??'N/A'}',
                      fontsize: 16.sp,
                    ),

                    SizedBox(height: 16.h),
                    CustomUploadButton(title: 'Signature.jpg', onTap: () {}),
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CustomText(
                        //   text: 'Date: ',
                        //   fontsize: 16.sp,
                        // ),
                        SizedBox(width: 5.h),
                        CustomText(
                          maxline: 5,
                          bottom: 24.h,
                          textAlign: TextAlign.start,
                          text: DateFormat('dd MMM yyyy').format(DateTime.parse('${towTrackController.trackProfile.value.authDate ?? 'N/A'}')),
                          fontsize: 16.sp,
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 25.h,)
            ],
          ),
        ),
      ),
    );
  }



  String getFileName(String? path) {
    if (path == null || path.trim().isEmpty) return 'Not uploaded';
    path = path.replaceAll('\\', '/');
    return path.split('/').last;
  }
}
