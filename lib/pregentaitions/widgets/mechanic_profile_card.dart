import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_image_avatar.dart';
import 'custom_text.dart';

class MechanicProfileCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final double rating;
  final double? height;

  const MechanicProfileCard({
    Key? key,
    required this.image,
    required this.name,
    required this.location,
    required this.rating,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393.w,
      height: height ??  218.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 1.r),
            ),
            child: CustomImageAvatar(
              image: image,
              radius: 44.r,
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: name,
                fontsize: 20.sp,
                bottom: 6.h,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  CustomText(
                    text: location,
                    fontsize: 14.sp,
                    color: Colors.black,
                  ),
                  CustomText(
                    text: '   |   ',
                    fontsize: 14.sp,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.star,
                    size: 16.r,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    text: rating.toString(),
                    fontsize: 14.sp,
                    color: Colors.black,
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
