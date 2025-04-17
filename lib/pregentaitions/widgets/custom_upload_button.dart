import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUploadButton extends StatelessWidget {
  const CustomUploadButton({super.key, required this.title, this.icon, required this.onTap});

  final String title;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      alignment: Alignment.center,
      radiusAll: 16.r,
      marginAll: 8.h,
      width: double.infinity,
      height: 32.h,
      color: AppColors.pdfButtonColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon != null )
          Icon(icon ,color: Colors.white,size: 20.sp,),
          SizedBox(width: 8.w),
          CustomText(text: 'DOT registration.pdf',color: Colors.white,),
        ],
      ),
    );
  }
}
