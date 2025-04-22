import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_slider.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MechanicJobRequestScreen extends StatefulWidget {
  const MechanicJobRequestScreen({super.key});

  @override
  State<MechanicJobRequestScreen> createState() => _MechanicJobRequestScreenState();
}

class _MechanicJobRequestScreenState extends State<MechanicJobRequestScreen> {


  double _miles = 4;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(

          actions: [
            Builder(
                builder: (context) {
                  return GestureDetector(
                      onTap: (){
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: Assets.icons.menu.svg());
                }
            ),

            SizedBox(width: 24.w)
          ],
          centerTitle: true,
          title: CustomText(
            maxline: 2,
            text: "Job",
            fontsize: 20.sp,
          )),


      endDrawer: Drawer(
        backgroundColor: AppColors.bgColorWhite,
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.fromLTRB(16.w,60.h,16.w,8.h),
            child: Column(
              children: [
                CustomText(text: 'Filter',color: AppColors.primaryColor,fontsize: 22.sp,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(text: 'Miles From Me',fontsize: 20.sp,left: 16.w,top: 16.h,)),

                CustomSlider(
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.switchColor,
                  thumbColor: Colors.grey.shade300,
                  value: _miles,
                  onChanged: (val){
                    _miles = val;
                    setState(() {

                    });
                  },
                ),
                CustomText(
                    text: 'Maximum',
                    fontsize: 12.sp,
                    bottom: 4.h),




                CustomContainer(
                  alignment: Alignment.center,
                  radiusAll: 12.r,
                  width: 95.w,
                  height: 42.h,
                  bordersColor: AppColors.primaryShade300,
                  child: CustomText(
                    text: _miles.toInt().toString(),
                    fontsize: 16.sp,
                  ),
                ),




                const Spacer(),
                CustomButton(title: 'Apply', onpress: () {

                },),
                SizedBox(height: 10.h,)
              ],
            ),
          ),
        ),
      ),

      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context,index) => CustomContainer(
            marginAll: 8.h,
            paddingAll: 8.h,
            color: AppColors.bgColorWhite,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 3)
            ],
            bordersColor: AppColors.borderColor,
            radiusAll: 16.r,
            paddingLeft: 8.r,
            child: Row(
              children: [
                CustomImageAvatar(image: '',radius: 38.r,),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      CustomText(text: 'David Bryan',fontsize: 16.sp,color: AppColors.textColor151515,),
                      Row(
                        children: [
                          CustomText(text: '26 March 11.00 AM',fontsize: 10.sp,color: AppColors.textColor151515 ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.directions_car_filled,
                            size: 14.r,
                            color: Colors.blue.shade600,
                          ),
                          SizedBox(width: 4.w),
                          CustomText(text: ' Sedan | In-shop',fontsize: 10.sp,color: AppColors.pdfButtonColor),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      CustomContainer(
                        alignment: Alignment.center,
                        width: 188.w,
                        height: 34.h,
                        color: AppColors.primaryColor,
                        radiusAll: 100.r,
                        child: CustomText(
                          text: 'Request',
                          fontsize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15.h),

                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }



}
