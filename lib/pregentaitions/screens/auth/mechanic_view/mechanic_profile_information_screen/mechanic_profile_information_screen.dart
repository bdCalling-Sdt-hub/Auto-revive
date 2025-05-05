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
import '../../../../../services/api_constants.dart';
import '../../../../widgets/cachanetwork_image.dart';
import '../../../../widgets/custom_upload_button.dart';

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
    return CustomScaffold(
      appBar: AppBar(
        centerTitle: false,
        title: CustomText(
          textAlign: TextAlign.start,
          text: "Personal Information",
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
                  children: [
                    CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl: "${ApiConstants.imageBaseUrl}/${mechanicController.profile.value.profileImage}" ?? "https://randomuser.me/api/portraits/men/10.jpg",
                      height: 128.h,
                      width: 128.w,
                    ),
                    SizedBox(width: 10.w),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 20.sp),
                        text: "${mechanicController.profile.value.name}",
                        children: [
                          TextSpan(
                            style: TextStyle(fontSize: 10.sp),
                            text:
                            '\n ${mechanicController.profile.value.role ?? 'N/A'} \n ${mechanicController.profile.value.phone ?? 'N/A'}     ||  ${mechanicController.profile.value.email ?? 'N/A'} \n ${mechanicController.profile.value.address ?? 'N/A'}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
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
                          // Have Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Have:',
                                fontsize: 16.sp,
                                color: AppColors.textColor151515,
                              ),
                              SizedBox(height: 13.h),
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

                          // Certificate Section
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
                      /// ==================================> Basic hand tools. ====================================>
                      CustomText(
                        text: 'Basic hand tools...',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text:
                        'Screwdrivers (Flat, Phillips, Torx).'
                            '\nPliers (Needle Nose, Slip Joint, Channel Lock, Wire Cutters).'
                            '\nRatchets (Standard & Flex Head).'
                            '\nWrenches (Combination, Box-End, Adjustable, Ratcheting).'
                            '\nAllen Wrenches / Hex Keys.'
                            '\nPry Bars.'
                            '\nHammers (Ball Peen, Dead Blow, Rubber Mallet)'
                            '\nTape Measure & Utility Knife.',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),
                      /// ==================================> Sockets & Ratchets ====================================>
                      CustomText(
                        text: 'Sockets & Ratchets...',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text:
                        "1/4\" Drive Sockets (Standard & Deep)."
                            '\n3/8\" Drive Sockets (Standard & Deep).'
                            '\n1/2\" Drive Sockets (Standard & Deep).'
                            '\n3/4\" Drive Sockets (Standard & Deep).'
                            '\n1\" Drive Sockets (Standard & Deep).'
                            '\nUniversal Joints & Extensions (All Drive Sizes).'
                            '\nTorque Wrench (1/4\", 3/8\", 1/2\", 3/4\", 1\").',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),
                      /// ==================================> Power & Pneumatic Tools ====================================>
                      CustomText(
                        text: 'Power & Pneumatic Tools...',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text:
                        'Cordless Drill & Bits.'
                            '\nElectric Ratchet (1/4\", 3/8\", 1/2\").'
                            '\nPneumatic Ratchet (1/4\", 3/8\", 1/2\").'
                            '\nImpact Gun (1/4\", 3/8\", 1/2\", 3/4\", 1\").'
                            '\nAir Compressor & Air Hoses.',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),
                      /// ==================================> Diagnostics Equipment ====================================>
                      CustomText(
                        text: 'Diagnostics Equipment...',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text:
                        'OBD2 Scanner.'
                            '\nDiesel Engine Diagnostic Scanner (OEM or Aftermarket).'
                            '\nBattery Tester & Charger.'
                            '\nMulti meter for Electrical Testing.'
                            '\nFuel Pressure Tester.'
                            '\nCooling System Pressure Tester.',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 16.h),
                      /// ==================================> Lifting and Support Equipment ====================================>
                      CustomText(
                        text: 'Lifting and Support Equipment...',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text:
                        'Hydraulic Jack (2-Ton, 10-Ton, 30-Ton).'
                            '\nJack Stands (Adjustable Height).'
                            '\nWheel Chocks.'
                            '\nCreeper & Rolling Seat.',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),
                      /// ==================================> Specialty Tools ====================================>
                      CustomText(
                        text: 'Specialty Tools...',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text:
                        'Brake Service Tools (Brake Spoon, Brake Spring Pliers.'
                            '\nOil Filter Wrenches & Drain Pan.'
                            '\nHose Clamp Pliers.'
                            '\nPick Set (O-Ring & Seal Removal).'
                            '\nThread Chaser Set.'
                            '\nTap & Die Set.'
                            '\nSnap Ring Pliers.'
                            '\nWheel End Hub Sockets.',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),
                      /// ==================================> Employment History ====================================>
                      CustomText(
                        text: 'Employment History',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Grease Monkey',
                        fontWeight: FontWeight.bold,
                        fontsize: 18.sp,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Sr. Mechanic, On-site',
                        fontsize: 10.sp,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'David Bryan',  // Make this bold
                        fontsize: 18.sp,
                        fontWeight: FontWeight.bold,  // Bold for name
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: '+746 478574'
                            '\n17 March 2023 to 12 Feb 2024'
                            '\nLeaving a job can be a tough decision, whether for growth, work-life balance, or a new opportunity...',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),

                      /// ==================================> Grease Monkey ====================================>
                      CustomText(
                        text: 'Grease Monkey',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Sr. Mechanic, On-site',
                        fontsize: 10.sp,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'David Brayan',
                        fontsize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: '+746 478574'
                            '\n17 March 2023 to 12 Feb 2024'
                            '\nLeaving a job can be a tough decision, whether for growth, work-life balance, or a new opportunity...',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),

                      /// ==================================> Reference 1 ====================================>
                      CustomText(
                        text: 'Reference 1',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Thomas David',  // Make this bold
                        fontsize: 18.sp,
                        fontWeight: FontWeight.bold,  // Bold for name
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: '+746 478574'
                            '\nDavid Brayan',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),

                      /// ==================================> Reference 2 ====================================>
                      CustomText(
                        text: 'Reference 2',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Thomas David',  // Make this bold
                        fontsize: 18.sp,
                        fontWeight: FontWeight.bold,  // Bold for name
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: '+746 478574'
                            '\nDavid Brayan',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),

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
                          text: 'I want to work at On-Site Fleet Services because of its commitment to quality maintenance and customer satisfaction. I am eager to apply my skills in a dynamic environment, contribute to the team, and grow professionally in the fleet services industry.',
                          fontsize: 10.sp,
                          color: AppColors.textColor151515),
                      SizedBox(height: 24.h),
                      /// ==================================> Employment History ====================================>
                      CustomText(
                        text: 'Employment History',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Grease Monkey'
                            '\nSr. Mechanic, On-site'
                            '\n', // Empty line for spacing
                        fontsize: 10.sp,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'David Bryan',  // Make this bold
                        fontsize: 10.sp,
                        fontWeight: FontWeight.bold,  // Bold for name
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: '+746 478574'
                            '\n17 March 2023 to 12 Feb 2024'
                            '\nLeaving a job can be a tough decision, whether for growth, work-life balance, or a new opportunity...',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),

                      /// ==================================> Grease Monkey ====================================>
                      CustomText(
                        text: 'Grease Monkey',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Sr. Mechanic, On-site'
                            '\n', // Empty line for spacing
                        fontsize: 10.sp,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'David Brayan',  // Make this bold
                        fontsize: 10.sp,
                        fontWeight: FontWeight.bold,  // Bold for name
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: '+746 478574'
                            '\n17 March 2023 to 12 Feb 2024'
                            '\nLeaving a job can be a tough decision, whether for growth, work-life balance, or a new opportunity...',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),

                      /// ==================================> Reference 1 ====================================>
                      CustomText(
                        text: 'Reference 1',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Thomas David',  // Make this bold
                        fontsize: 10.sp,
                        fontWeight: FontWeight.bold,  // Bold for name
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: '+746 478574'
                            '\nDavid Brayan',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),

                      /// ==================================> Pdf ====================================>
                      CustomText(
                        text: 'Reference 2',
                        fontsize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: 'Thomas David',
                        fontsize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: '+746 478574'
                            '\nDavid Brayan',
                        fontsize: 10.sp,
                      ),
                      SizedBox(height: 15.h),

                      CustomUploadButton(title: 'Resume.pdf', onTap: (){}),
                      SizedBox(height: 10.h),
                      CustomUploadButton(title: 'Certificate.pdf', onTap: (){}),

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
