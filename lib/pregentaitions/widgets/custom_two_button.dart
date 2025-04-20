import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomTwoButon extends StatelessWidget {
  final List? btnNameList;
  final VoidCallback? leftBtnOnTap;
  final double? width;
  final double? height;
  final VoidCallback? rightBtnOnTap;

  const CustomTwoButon(
      {super.key, this.btnNameList, this.leftBtnOnTap, this.rightBtnOnTap, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(btnNameList!.length, (index) {
        return GestureDetector(
          onTap: index == 0 ? leftBtnOnTap : rightBtnOnTap,

          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(8.r),
                color: index == 0 ? Colors.white : AppColors.primaryColor),
            width: width,
            height: height,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 7.w),
              child: CustomText(
                  text: btnNameList![index],
                  color: index == 0 ? AppColors.primaryColor : Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      }),
    );
  }
}
