import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../widgets/custom_upload_button.dart';

class MechanicProfileInformationScreen extends StatefulWidget {
   MechanicProfileInformationScreen({super.key});

  @override
  State<MechanicProfileInformationScreen> createState() => _MechanicProfileInformationScreenState();
}

class _MechanicProfileInformationScreenState extends State<MechanicProfileInformationScreen> {
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
          child: Column(
            children: [
              /// ==================================> Profile ====================================>
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageAvatar(
                    radius: 60.r,
                  ),
                  SizedBox(width: 10.w),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 20.sp),
                      text: 'Bryan  ',
                      children: [
                        // TextSpan(
                        //   style: TextStyle(
                        //       color: AppColors.primaryColor, fontSize: 20.sp),
                        //   text: '(\$25)',
                        // ),
                        TextSpan(
                          style: TextStyle(fontSize: 10.sp),
                          text:
                          '\n Mechanic \n +784 8954958     ||   bryan@gmail.com \n USA, New York',
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
                                _buildTag('valid Driver License'),
                                SizedBox(width: 10.w),
                                _buildTag('CDL'),
                              ],
                            ),
                          ],
                        ),

                        // Certificate Section
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
                              children: [
                                _buildTag('ASE'),
                                _buildTag('OEM'),
                                _buildTag('DOT'),
                              ],
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
                    /// ======================================> ListView to display the experience items =============================>
                    SizedBox(
                      height: 400.h,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: experienceItems.length,
                        itemBuilder: (context, index) {
                          return _buildExperienceRow(
                            experienceItems[index][0], // Title
                            experienceItems[index][1], // Location
                            experienceItems[index][2], // Duration
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 15.h),

                    SizedBox(height: 10.h),
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




  final List<List<String>> experienceItems = [
    ['Diesel Engine Repair', 'In Shop', '4 year'],
    ['Gasoline Engine Repair', 'On site', '9 year'],
    ['Semi Truck Repair', 'Other', '5 year'],
    ['Trailer Repair', 'In Shop', '1 year'],
    ['RV Repair', 'On site', '3 year'],
    ['Electrical Diagnostics', 'Other', '1 year'],
    ['Brake Systems', 'In Shop', '5 year'],
    ['Welding & Fabrication', 'On site', '3 year'],
    ['Computer Diagnostics', 'Other', '1 year'],
    ['Hydraulic Systems', 'In Shop', '4 year'],
  ];


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
