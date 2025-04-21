import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_slider.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TowTruckJobRequestScreen extends StatefulWidget {
  const TowTruckJobRequestScreen({super.key});

  @override
  State<TowTruckJobRequestScreen> createState() => _TowTruckJobRequestScreenState();
}

class _TowTruckJobRequestScreenState extends State<TowTruckJobRequestScreen> {


   double _miles = 4;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 16.w),
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
                  activeColor: AppColors.primaryShade300,
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
                CustomContainer(
                  color: AppColors.primaryShade300,
                  paddingAll: 10.r,
                  radiusAll: 100.r,
                  width: double.infinity,
                  bordersColor: Colors.red,
                  child: CustomText(text: 'Apply',color: Colors.white,),
                ),
              ],
            ),
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: 5,
          itemBuilder: (context,index) => CustomContainer(
            marginAll: 8.h,
            color: AppColors.bgColorWhite,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'David Bryan',fontsize: 16.sp,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 10.sp,color: AppColors.pdfButtonColor,height: 1.6),
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.directions_car_filled, size: 14.r,color: AppColors.pdfButtonColor,),
                      ),
                      const TextSpan(
                        text: ' Sedan \n Distance: 23 KM',
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 10.h),

                CustomContainer(
                  alignment: Alignment.center,
                  width: 188.w,
                  height: 28.h,
                  color: AppColors.primaryColor,
                  radiusAll: 100.r,
                  child: CustomText(
                    text: 'Request',
                    fontsize: 10.sp,
                    color: Colors.white,
                  ),
                ),

              ],
            )
          ],
        ),
      )),
    );
  }
}
