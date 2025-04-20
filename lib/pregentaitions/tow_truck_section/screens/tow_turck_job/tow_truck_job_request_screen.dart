import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TowTruckJobRequestScreen extends StatelessWidget {
  const TowTruckJobRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                maxline: 2,
                text: "Job",
                fontsize: 20.sp,
              ),
              CustomContainer(
                child: Assets.icons.menu.svg(),
              ),
            ],
          )),

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
