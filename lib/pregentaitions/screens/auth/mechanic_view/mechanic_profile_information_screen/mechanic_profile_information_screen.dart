import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/custom_button.dart';

class MechanicProfileInformationScreen extends StatelessWidget {
  const MechanicProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          centerTitle: false,
          title: CustomText(
            textAlign: TextAlign.start,
            text: "Personal Information",
            fontsize: 20.sp,
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageAvatar(
                    radius: 60.r,
                  ),
                  SizedBox(width: 10.w,),
                  RichText(
                      text: TextSpan(
                          style:
                          TextStyle(color: Colors.black, fontSize: 20.sp),
                          text: 'Bryan  ',
                          children: [
                            TextSpan(
                                style: TextStyle(
                                    color: AppColors.primaryColor, fontSize: 20.sp),
                                text: '(\$25)'),
                            TextSpan(
                                style: TextStyle(fontSize: 10.sp),
                                text:
                                '\n Tow truck owner \n +784 8954958     ||   bryan@gmail.com \n USA, New York'),
                          ]))
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
                   Row(
                     children: [
                       CustomText(text: 'Have: ',),
                       SizedBox(width: 35.w),
                       CustomText(text: 'Certificate: ',),
                     ],
                   ),
                    SizedBox(height: 13.h),
                    CustomText(text: 'Comfortable working on-site (roadside, fleet yards, job sites)'),
                    SizedBox(height: 15.h),
                    CustomText(text: 'Experience and More',fontsize: 16.sp,fontWeight: FontWeight.bold),

                    CustomText(text: 'Diesel Engine Repair',),
                    CustomText(text: 'Basic hand tools...',fontsize: 16.sp,fontWeight: FontWeight.bold),
                    CustomText(
                      textAlign: TextAlign.start,
                      text: 'Screwdrivers (Flat, Phillips, Torx).'
                          '\nPliers (Needle Nose, Slip Joint, Channel Lock,Wire Cutters).'
                          '\nRatchets (Standard & Flex Head).'
                          '\nWrenches (Combination, Box-End, Adjustable,Ratcheting). '
                          '\n Allen Wrenches / Hex Keys.'
                          '\nPry Bars.'
                          '\nHammers (Ball Peen, Dead Blow, Rubber Mallet)'
                          '\nTape Measure & Utility Knife.',
                      fontsize: 10.sp,
                    ),

                    const Divider(color: AppColors.borderColor),


                    // CustomUploadButton(
                    //   title: 'DOT registration.pdf',
                    //   onTap: () {},
                    //   showUploadIcon: false,
                    // ),

                    // /// ++++++++++++++++ 2st Step +++++++++++++++++++++++
                    // CustomText(
                    //     top: 16.h,
                    //     textAlign: TextAlign.start,
                    //     text:
                    //     'Have commercial insurance coverage \nPolicy Number : 85873 7384 \nCoverage Limits : 833 KM'),
                    // CustomUploadButton(
                    //   title: 'insurancePolicy.pdf',
                    //   onTap: () {},
                    //   showUploadIcon: false,
                    // ),
                    //
                    // /// ++++++++++++++++ 3th Step +++++++++++++++++++++++
                    // CustomText(
                    //     top: 16.h,
                    //     textAlign: TextAlign.start,
                    //     text:
                    //     'Have a valid Motor Carrier (MC) number. \nMC Number : 85873 7384 \nCoverage Limits : 833 KM'),
                    // CustomUploadButton(
                    //   title: 'mc.pdf',
                    //   onTap: () {},
                    //   showUploadIcon: false,
                    // ),

                    const Divider(
                      color: AppColors.borderColor,
                    ),

                    /// ++++++++++++++++ 4th Step +++++++++++++++++++++++
                    // CustomText(
                    //   text: 'Vehicle and Equipment',
                    //   fontsize: 20.sp,
                    // ),
                    // CustomText(
                    //     textAlign: TextAlign.start,
                    //     text:
                    //     'Making Year: 2023 \nBrand: Ford \nModel: T-376237 \nGVWR: 500 Ton \nType of tow truck: Flatbet'),
                    // CustomUploadButton(
                    //   title: 'towtruck.mp4',
                    //   onTap: () {},
                    //   showUploadIcon: false,
                    // ),

                    const Divider(
                      color: AppColors.borderColor,
                    ),

                    /// ++++++++++++++++ 5th Step +++++++++++++++++++++++

                    // CustomText(
                    //   text: 'Service and Coverage Area',
                    //   fontsize: 20.sp,
                    // ),
                    // CustomText(
                    //   text: 'Types of towing services do we offer.',
                    //   fontsize: 16.sp,
                    // ),
                    // CustomText(
                    //   textAlign: TextAlign.start,
                    //   text: 'Light-Duty Towing (Cars & Small Trucks) '
                    //       '\nMedium-Duty Towing (Box Trucks & RVs) '
                    //       '\nHeavy-Duty Towing (Semis & Large Trucks) '
                    //       '\nRoadside Assistance (Jump-starts, Lockouts, Fuel Delivery). '
                    //       '\n Winch-Out & Recovery Services '
                    //       '\nEquipment Transport',
                    //   fontsize: 10.sp,
                    // ),
                    // CustomText(
                    //   textAlign: TextAlign.start,
                    //   text: 'Primary service area: USA, New York '
                    //       '\nRegions Covered: Full USA '
                    //       '\nWe offer 24/7 support. '
                    //       '\nAverage ETA for service calls : Over 1 hour',
                    //   fontsize: 16.sp,
                    // ),

                    /// ++++++++++++++++ 6th Step +++++++++++++++++++++++

                    // const Divider(
                    //   color: AppColors.borderColor,
                    // ),
                    //
                    // CustomText(
                    //   textAlign: TextAlign.start,
                    //   maxline: 2,
                    //   text: 'Business requirements and agreements',
                    //   fontsize: 20.sp,
                    // ),
                    // CustomText(
                    //   maxline: 2,
                    //   textAlign: TextAlign.start,
                    //   text:
                    //   'By applying to work with Fix It LLC, you agree to the following.',
                    //   fontsize: 16.sp,
                    // ),
                    // CustomText(
                    //   textAlign: TextAlign.start,
                    //   text:
                    //   'Maintain active DOT registration & insurance coverage at all times. '
                    //       '\nAdhere to all local, state, and federal regulations for towing \noperations.'
                    //       '\n Provide timely and professional service for Fix It LLC customers.'
                    //       '\nMaintain clean and well-maintained tow trucks and equipment.'
                    //       '\nCommunicate accurate ETAs and service updates.'
                    //       '\nSubmit a live walk-around video showing that all trucks meet \noperational standards.',
                    //   fontsize: 10.sp,
                    // ),
                    // CustomText(
                    //   maxline: 2,
                    //   textAlign: TextAlign.start,
                    //   text: 'Authorized or Representative name : David Hook',
                    //   fontsize: 16.sp,
                    // ),
                    // CustomText(
                    //   maxline: 2,
                    //   textAlign: TextAlign.start,
                    //   text:
                    //   'Authorized or Representative title : General manager ',
                    //   fontsize: 16.sp,
                    // ),

                    // SizedBox(height: 16.h),
                    // CustomUploadButton(title: 'Signature.jpg', onTap: (){}),
                    // CustomText(
                    //   bottom: 24.h,
                    //   textAlign: TextAlign.start,
                    //   text:
                    //   'Date: 15 March 2025 ',
                    //   fontsize: 16.sp,
                    // ),


                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton        (
                title: "Submit",
                onpress: () {
                  // Action after saving data and moving to next screen

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
