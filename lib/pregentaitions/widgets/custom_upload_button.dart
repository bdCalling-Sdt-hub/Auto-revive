import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUploadButton extends StatelessWidget {
  const CustomUploadButton({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
    this.topLabel,
    this.showUploadIcon = true,
  });

  final String title;
  final String? topLabel;
  final IconData? icon;
  final bool showUploadIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    IconData? displayIcon;

    // Determine which icon to show
    if (showUploadIcon) {
      displayIcon = icon ?? Icons.upload;
    } else if (icon != null) {
      displayIcon = icon;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topLabel != null)
          CustomText(
            text: topLabel!,
          ),
        CustomContainer(
          onTap: onTap,
          alignment: Alignment.center,
          radiusAll: 16.r,
          marginAll: 8.h,
          width: double.infinity,
          height: 45.h,
          color: AppColors.pdfButtonColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (displayIcon != null) ...[
                Icon(
                  displayIcon,
                  color: Colors.white,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
              ],
              CustomText(
                text: title,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
