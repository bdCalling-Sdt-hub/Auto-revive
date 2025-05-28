
import 'package:autorevive/controllers/towTrack/registration_tow_track_controller.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/config/app_routes/app_routes.dart';
import '../../../../../../global/custom_assets/assets.gen.dart';
import '../../../../../../services/api_constants.dart';
import '../../../../../widgets/cachanetwork_image.dart';

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
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Obx(() {
                final profile = towTrackController.trackProfile.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  /// ==========================================> Profile =============================================>
                  children: [
                    CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl: (profile.profileImage == null || profile.profileImage!.isEmpty)
                          ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                          : "${ApiConstants.imageBaseUrl}/${profile.profileImage}",
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
                            height: 1.4,
                          ),
                          text: profile.name ?? 'N/A',
                          children: [
                            TextSpan(
                              style: TextStyle(fontSize: 10.sp),
                              text:
                              '\n${profile.role ?? ""}'
                                  '\n${profile.phone ?? ""} || ${profile.email ?? ""}'
                                  '\n${profile.address ?? ""}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await towTrackController.getTowTrackProfile();
                        context.pushNamed(
                          AppRoutes.towTrackBasicInfoScreen,
                          extra: {
                            "title": "Basic Info...",
                            "isEdit": true,
                            "name": profile.name ?? '',
                            "phone": profile.phone ?? '',
                            "address": profile.address ?? '',
                            "ppm": profile.ppm ?? '',
                            "llc": profile.llc ?? '',
                            "image": profile.profileImage != null && profile.profileImage!.isNotEmpty
                                ? "${ApiConstants.imageBaseUrl}/${profile.profileImage}"
                                : "",
                          },
                        ).then((_) => towTrackController.getTowTrackProfile());
                      },
                      child: Assets.icons.editIcon.svg(),
                    ),
                  ],
                );
              }),
              /// ==========================================> Company Information ========================================>
              SizedBox(height: 16.h),
              Obx(() {
                final profile = towTrackController.trackProfile.value;
                return CustomContainer(
                  paddingAll: 16.h,
                  radiusAll: 8.r,
                  bordersColor: AppColors.borderColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CustomText(
                          text: profile.companyName ?? '',
                          fontsize: 18.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.companyInformationScreen,
                            extra: {
                              "title": "Company Information",
                              "isEdit": true,
                              "companyName": profile.companyName ?? '',
                              "companyOwner": profile.companyOwner ?? '',
                              "companyPhone": profile.companyPhone ?? '',
                              "website": profile.website ?? '',
                              "yearsInBusiness": profile.yearsInBusiness ?? '',
                              "totalTows": profile.totalTows ?? '',
                              "einNo": profile.einNo ?? '',
                            },
                          ).then((_) => towTrackController.getTowTrackProfile());
                        },
                        child: Assets.icons.editIcon.svg(),
                      ),
                      Center(
                        child: CustomText(
                          text: 'Owner: ${profile.companyOwner ?? ""}',
                          fontsize: 13.sp,
                        ),
                      ),
                      CustomText(
                        bottom: 20.h,
                        maxline: 10,
                        text:
                        'Contact: ${profile.companyPhone ?? ""} | ${profile.companyEmail ?? ""} | ${profile.website ?? ""} '
                            '\nYears of business: ${profile.yearsInBusiness ?? ""} | Number of tow trucks: ${profile.totalTows ?? ""} '
                            '\nEIN number: ${profile.einNo ?? ""}',
                        fontsize: 10.sp,
                      ),
                      const Divider(color: AppColors.borderColor),
               /// =======================================> Licensing and Compliance =====================================>
                      CustomText(
                        text: 'Licensing and Compliance',
                        fontsize: 20.sp,
                      ),
                      CustomText(
                        maxline: 2,
                        textAlign: TextAlign.start,
                        text: 'Have a valid US-DOT number'
                            '\nUS-DOT number: ${profile.usDotNo ?? ""}',
                      ),
                      CustomUploadButton(
                        title: 'US-DOT number.pdf',
                        onTap: () {},
                        showUploadIcon: false,
                      ),
              /// ===================================> commercial insurance ===============================================>
                      CustomText(
                        maxline: 10,
                        top: 16.h,
                        textAlign: TextAlign.start,
                        text: 'Have commercial insurance coverage '
                            '\nPolicy Number : ${profile.policyNo ?? ""} '
                            '\nCoverage Limits : ${profile.policyLimit ?? ""}',
                      ),
                      CustomUploadButton(
                        title: 'Insurance.pdf',
                        onTap: () {},
                        showUploadIcon: false,
                      ),
                      /// ==============================================> Mc Number =================================>

                      CustomText(
                        maxline: 10,
                        top: 16.h,
                        textAlign: TextAlign.start,
                        text: 'Have a valid Motor Carrier (MC) number. '
                            '\nMC Number : ${profile.mcNo ?? ""} '
                            '\nCoverage Limits : ${profile.policyLimit ?? ""}',
                      ),
                      CustomUploadButton(
                        title: 'Mc.pdf',
                        onTap: () {},
                        showUploadIcon: false,
                      ),

                      const Divider(color: AppColors.borderColor),
                      /// ====================================>  Vehicle and Equipment ========================================>

                      CustomText(
                        text: 'Vehicle and Equipment',
                        fontsize: 20.sp,
                      ),

                      // Vehicles list replaced ListView.builder with Column + List.generate
                      if ((profile.vehicles?.isNotEmpty ?? false))
                        Column(
                          children: List.generate(profile.vehicles!.length, (index) {
                            final vehicle = profile.vehicles![index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    maxline: 10,
                                    textAlign: TextAlign.start,
                                    text:
                                    'Making Year: ${vehicle.year ?? ""} '
                                        '\nBrand: ${vehicle.brand ?? ""} '
                                        '\nModel: ${vehicle.modelNo ?? ""} '
                                        '\nGVWR: ${vehicle.gvwr ?? ""} '
                                        '\nType of tow truck: ${vehicle.type ?? ""}',
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomUploadButton(
                                    title: 'towTrack.Mp4',
                                    onTap: () {

                                    },
                                    showUploadIcon: false,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),

                      const Divider(color: AppColors.borderColor),
                      /// ====================================> Service and Coverage =============================================>

                      CustomText(
                        text: 'Service and Coverage Area',
                        fontsize: 20.sp,
                      ),
                      CustomText(
                        text: 'Types of towing services do we offer.',
                        fontsize: 16.sp,
                      ),

                      // Services list replaced ListView.builder with Column + List.generate
                      if ((profile.services?.isNotEmpty ?? false))
                        Column(
                          children: List.generate(profile.services!.length, (index) {
                            final service = profile.services![index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: CustomText(
                                textAlign: TextAlign.start,
                                text: service ?? '',
                                fontsize: 10.sp,
                              ),
                            );
                          }),
                        ),

                      CustomText(
                        maxline: 10,
                        textAlign: TextAlign.start,
                        text:
                        'Primary service area: ${profile.primaryCity ?? ""} '
                            '\nRegions Covered: ${profile.regionsCovered ?? ""}'
                            '\n${profile.emergency247 ?? ""}'
                            '\nAverage ETA for service calls : ${profile.eta ?? ""}',
                        fontsize: 16.sp,
                      ),

                      const Divider(color: AppColors.borderColor),
                      /// ======================================> Business requirements ======================================>

                      CustomText(
                        textAlign: TextAlign.start,
                        maxline: 2,
                        text: 'Business requirements and agreements',
                        fontsize: 20.sp,
                      ),
                      CustomText(
                        maxline: 5,
                        textAlign: TextAlign.start,
                        text: 'By applying to work with Fix It LLC, you agree to the following.',
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
                        text: 'Authorized or Representative name : ${profile.authName ?? ""}',
                        fontsize: 16.sp,
                      ),
                      CustomText(
                        maxline: 5,
                        textAlign: TextAlign.start,
                        text: 'Authorized or Representative title : ${profile.authTitle ?? ""}',
                        fontsize: 16.sp,
                      ),

                      SizedBox(height: 16.h),
                      CustomUploadButton(title: 'Signature.jpg', onTap: () {}),
                      SizedBox(height: 10.h),
                      SizedBox(width: 5.h),
                      CustomText(
                        maxline: 5,
                        bottom: 24.h,
                        textAlign: TextAlign.start,
                        text: '${profile.authDate ?? ""}',
                        fontsize: 16.sp,
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 25.h),
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






















//
// import 'package:autorevive/controllers/towTrack/registration_tow_track_controller.dart';
// import 'package:autorevive/core/constants/app_colors.dart';
// import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
// import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
// import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
// import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../../../core/config/app_routes/app_routes.dart';
// import '../../../../../../global/custom_assets/assets.gen.dart';
// import '../../../../../../services/api_constants.dart';
// import '../../../../../widgets/cachanetwork_image.dart';
//
//
// class ProfileDetailsScreen extends StatefulWidget {
//   const ProfileDetailsScreen({super.key});
//
//   @override
//   State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
// }
//
// class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
//
//   TowTrackController towTrackController = Get.put(TowTrackController());
//
//
//   @override
//   void initState() {
//     towTrackController.getTowTrackProfile();
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       appBar: AppBar(
//           centerTitle: false,
//           title: CustomText(
//             textAlign: TextAlign.start,
//             text: "Profile Details",
//             fontsize: 20.sp,
//           )),
//       body: Obx(()=>
//
//       SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 Row(
//                   /// =================================> ProfileImage ================================>
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomNetworkImage(
//                       boxShape: BoxShape.circle,
//                       imageUrl:
//                       towTrackController.trackProfile.value.profileImage == null ||   towTrackController.trackProfile.value.profileImage == "" ?
//                       "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" :
//                       "${ApiConstants.imageBaseUrl}/${ towTrackController.trackProfile.value.profileImage}",
//                       height: 128.h,
//                       width: 128.w,
//                     ),
//                     SizedBox(width: 10.w),
//                     Flexible(
//                       child: RichText(
//                           text: TextSpan(
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20.sp,
//                                   height: 1.4),
//                               text: towTrackController.trackProfile.value.name ?? 'N/A',
//                               children: [
//                             // TextSpan(
//                             //     style: TextStyle(
//                             //         color: AppColors.primaryColor,
//                             //         fontSize: 20.sp),
//                             //     text: '(\$25)'),
//                             TextSpan(
//                                 style: TextStyle(fontSize: 10.sp),
//                                 text: '\n ${towTrackController.trackProfile.value.role}'
//                                     '\n ${towTrackController.trackProfile.value.phone}     ||   ${towTrackController.trackProfile.value.email} '
//                                     '\n ${towTrackController.trackProfile.value.address}'),
//                           ])),
//                     ),
//
//                     GestureDetector(
//                       onTap: () async {
//                         await towTrackController.getTowTrackProfile(); // Ensure profile loaded
//                         context.pushNamed(
//                           AppRoutes.towTrackBasicInfoScreen,
//                           extra: {
//                             "title": "Basic Info...",
//                             "isEdit": true,
//                             "name": towTrackController.trackProfile.value.name ?? '',
//                             "phone": towTrackController.trackProfile.value.phone ?? '',
//                             "address": towTrackController.trackProfile.value.address ?? '',
//                             "ppm": towTrackController.trackProfile.value.ppm ?? '',
//                             "llc": towTrackController.trackProfile.value.llc ?? '',
//                             "image": towTrackController.trackProfile.value.profileImage != null ? "${ApiConstants.imageBaseUrl}/${towTrackController.trackProfile.value.profileImage}": "",
//                           },
//                         ).then((_) {
//                           print('===========================================test');
//                           towTrackController.getTowTrackProfile();
//                         });
//                       },
//                       child: Assets.icons.editIcon.svg(),
//                     ),
//
//                   ],
//                 ),
//                 SizedBox(height: 16.h),
//
//                 /// ==============================================> Company Info Services ==================================>
//                 CustomContainer(
//                   paddingAll: 16.h,
//                   radiusAll: 8.r,
//                   bordersColor: AppColors.borderColor,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                           child: CustomText(
//                         text: '${towTrackController.trackProfile.value.companyName}',
//                         fontsize: 18.sp,
//                       )),
//                       GestureDetector(
//                         onTap: ()  {
//                           context.pushNamed(
//                             AppRoutes.companyInformationScreen,
//                             extra: {
//                               "title": "Company Information",
//                               "isEdit": true,
//                               "companyName": towTrackController.trackProfile.value.companyName ?? '',
//                               "companyOwner": towTrackController.trackProfile.value.companyOwner ?? '',
//                               "companyPhone": towTrackController.trackProfile.value.companyPhone ?? '',
//                               "website": towTrackController.trackProfile.value.website ?? '',
//                               "yearsInBusiness": towTrackController.trackProfile.value.yearsInBusiness ?? '',
//                               "totalTows": towTrackController.trackProfile.value.totalTows ?? '',
//                               "einNo": towTrackController.trackProfile.value.einNo ?? '',
//
//                             },
//                           ).then((_) {
//                             print('===========================================test');
//                             towTrackController.getTowTrackProfile();
//                           });
//                         },
//                         child: Assets.icons.editIcon.svg(),
//                       ),
//
//                       Center(
//                           child: CustomText(
//                         text: 'Owner: ${towTrackController.trackProfile.value.companyOwner}',
//                         fontsize: 13.sp,
//                       )),
//                       CustomText(
//                         bottom: 20.h,
//                         maxline: 10,
//                         text:
//                             'Contact: ${towTrackController.trackProfile.value.companyPhone} | ${towTrackController.trackProfile.value.companyEmail} | ${towTrackController.trackProfile.value.website} '
//                             '\nYears of business: ${towTrackController.trackProfile.value.yearsInBusiness} | Number of tow trucks: ${towTrackController.trackProfile.value.totalTows} '
//                             '\nEIN number: ${towTrackController.trackProfile.value.einNo}',
//                         fontsize: 10.sp,
//                       ),
//                       const Divider(
//                         color: AppColors.borderColor,
//                       ),
//
//                       /// ============================>  Licensing and Compliance =========================>
//                       CustomText(
//                         text: 'Licensing and Compliance',
//                         fontsize: 20.sp,
//                       ),
//                       CustomText(
//                           maxline: 2,
//                           textAlign: TextAlign.start,
//                           text: 'Have a valid US-DOT number'
//                               '\nUS-DOT number: ${towTrackController.trackProfile.value.usDotNo}'),
//                       CustomUploadButton(
//                         title: 'US-DOT number.pdf',
//                         // getFileName(towTrackController.trackProfile.value.usDotFile),
//                         onTap: () {
//
//                         },
//                         showUploadIcon: false,
//                       ),
//
//                       /// ++++++++++++++++ 2st Step +++++++++++++++++++++++
//                       CustomText(
//                           maxline: 10,
//                           top: 16.h,
//                           textAlign: TextAlign.start,
//                           text: 'Have commercial insurance coverage '
//                               '\nPolicy Number : ${towTrackController.trackProfile.value.policyNo} '
//                               '\nCoverage Limits : ${towTrackController.trackProfile.value.policyLimit}'),
//                       CustomUploadButton(
//                         title: 'Insurance.pdf',
//                         // towTrackController.trackProfile.value.policyFile ?? 'N/A',
//                         onTap: () {
//
//                         },
//                         showUploadIcon: false,
//                       ),
//
//                       /// ++++++++++++++++ 3th Step +++++++++++++++++++++++
//                       CustomText(
//                           maxline: 10,
//                           top: 16.h,
//                           textAlign: TextAlign.start,
//                           text: 'Have a valid Motor Carrier (MC) number. '
//                               '\nMC Number : ${towTrackController.trackProfile.value.mcNo} '
//                               '\nCoverage Limits : ${towTrackController.trackProfile.value.policyLimit}'),
//                       CustomUploadButton(
//                         title: 'Mc.pdf',
//                         // towTrackController.trackProfile.value.mcFile ?? 'N/A',
//                         onTap: () {
//
//                         },
//                         showUploadIcon: false,
//                       ),
//
//                       const Divider(
//                         color: AppColors.borderColor,
//                       ),
//
//                       /// ++++++++++++++++ 4th Step +++++++++++++++++++++++
//                       CustomText(
//                         text: 'Vehicle and Equipment',
//                         fontsize: 20.sp,
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: towTrackController.trackProfile.value.vehicles?.length,
//                         itemBuilder: (context, index) {
//                           final vehicle = towTrackController.trackProfile.value.vehicles?[index];
//                           return Padding(
//                             padding: EdgeInsets.symmetric(vertical: 8.h),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CustomText(
//                                   maxline: 10,
//                                   textAlign: TextAlign.start,
//                                   text: 'Making Year: ${vehicle?.year} '
//                                       '\nBrand: ${vehicle?.brand} '
//                                       '\nModel: ${vehicle?.modelNo} '
//                                       '\nGVWR: ${vehicle?.gvwr} '
//                                       '\nType of tow truck: ${vehicle?.type}',
//                                 ),
//                                 SizedBox(height: 10.h),
//                                 CustomUploadButton(
//                                   title: 'towTrack.Mp4',
//                                   // '${vehicle?.video}',
//                                   onTap: () {
//
//                                   },
//                                   showUploadIcon: false,
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//
//                       const Divider(
//                         color: AppColors.borderColor,
//                       ),
//
//                       /// ++++++++++++++++ 5th Step +++++++++++++++++++++++
//
//                       CustomText(
//                         text: 'Service and Coverage Area',
//                         fontsize: 20.sp,
//                       ),
//                       CustomText(
//                         text: 'Types of towing services do we offer.',
//                         fontsize: 16.sp,
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: towTrackController.trackProfile.value.services?.length,
//                         itemBuilder: (context, index) {
//                           final services = towTrackController.trackProfile.value.services?[index];
//                           return Padding(
//                             padding: EdgeInsets.symmetric(vertical: 4.h),
//                             child: CustomText(
//                               textAlign: TextAlign.start,
//                               text: '${services}',
//                               fontsize: 10.sp,
//                             ),
//                           );
//                         },
//                       ),
//
//                       CustomText(
//                         maxline: 10,
//                         textAlign: TextAlign.start,
//                         text: 'Primary service area: ${towTrackController.trackProfile.value.primaryCity} '
//                             '\nRegions Covered: ${towTrackController.trackProfile.value.regionsCovered}'
//                             '\n${towTrackController.trackProfile.value.emergency247}'
//                             '\nAverage ETA for service calls : ${towTrackController.trackProfile.value.eta}',
//                         fontsize: 16.sp,
//                       ),
//
//                       /// ++++++++++++++++ 6th Step +++++++++++++++++++++++
//
//                       const Divider(
//                         color: AppColors.borderColor,
//                       ),
//
//                       CustomText(
//                         textAlign: TextAlign.start,
//                         maxline: 2,
//                         text: 'Business requirements and agreements',
//                         fontsize: 20.sp,
//                       ),
//                       CustomText(
//                         maxline: 5,
//                         textAlign: TextAlign.start,
//                         text:
//                             'By applying to work with Fix It LLC, you agree to the following.',
//                         fontsize: 16.sp,
//                       ),
//                       CustomText(
//                         maxline: 20,
//                         textAlign: TextAlign.start,
//                         text:
//                             'Maintain active DOT registration & insurance coverage at all times. '
//                             '\nAdhere to all local, state, and federal regulations for towing \noperations.'
//                             '\n Provide timely and professional service for Fix It LLC customers.'
//                             '\nMaintain clean and well-maintained tow trucks and equipment.'
//                             '\nCommunicate accurate ETAs and service updates.'
//                             '\nSubmit a live walk-around video showing that all trucks meet \noperational standards.',
//                         fontsize: 10.sp,
//                       ),
//                       CustomText(
//                         maxline: 5,
//                         textAlign: TextAlign.start,
//                         text: 'Authorized or Representative name : ${towTrackController.trackProfile.value.authName}',
//                         fontsize: 16.sp,
//                       ),
//                       CustomText(
//                         maxline: 5,
//                         textAlign: TextAlign.start,
//                         text:
//                             'Authorized or Representative title : ${towTrackController.trackProfile.value.authTitle}',
//                         fontsize: 16.sp,
//                       ),
//
//                       SizedBox(height: 16.h),
//                       CustomUploadButton(title: 'Signature.jpg', onTap: () {}),
//                       SizedBox(height: 10.h),
//                       SizedBox(width: 5.h),
//                       CustomText(
//                         maxline: 5,
//                         bottom: 24.h,
//                         textAlign: TextAlign.start,
//                         text: '${towTrackController.trackProfile.value.authDate}',
//                         fontsize: 16.sp,
//                       ),
//
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 25.h,)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   String getFileName(String? path) {
//     if (path == null || path.trim().isEmpty) return 'Not uploaded';
//     path = path.replaceAll('\\', '/');
//     return path.split('/').last;
//   }
// }
