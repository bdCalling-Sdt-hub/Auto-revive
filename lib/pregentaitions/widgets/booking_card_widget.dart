import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingCardWidget extends StatelessWidget {
  const BookingCardWidget({
    super.key,
    this.rating,
    this.buttonLabel,
    this.onTapDetails,
    required this.name,
    this.title,
    required this.subTitle,
    required this.image,
    this.isAccepted = false,
    this.isHistory = false,
    this.status,
    this.historyButtonAction,
    this.buttonColor,
    this.onTap,
  });

  final int? rating;
  final String? buttonLabel;
  final VoidCallback? onTapDetails;
  final VoidCallback? onTap;
  final String name;
  final String? title;
  final String image;
  final String subTitle;
  final bool isAccepted;
  final bool isHistory;
  final String? status;
  final VoidCallback? historyButtonAction;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: CustomContainer(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 13)
        ],
        radiusAll: 14.r,
        paddingAll: 20.r,
        color: AppColors.bgColorWhite,
        child: Column(
          children: [
            if (isAccepted || isHistory) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: historyButtonAction,
                      child: CustomText(
                        text: status ?? '',
                        fontsize: 10.sp,
                        color: status == 'Cancel'
                            ? AppColors.cancelButtonColor
                            : AppColors.primaryColor,
                      )),
                  Assets.icons.location.svg(),
                ],
              ),
              SizedBox(height: 10.h),
            ],
            GestureDetector(
              onTap: onTapDetails,
              child: Row(
                children: [
                  CustomImageAvatar(
                    radius: 32.r,
                    image: image,
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        fontsize: 20.sp,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColors.pdfButtonColor,
                              height: 1.6),
                          children: [
                            if (title != null)
                              TextSpan(
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.black),
                                text: ' $title \n',
                              ),
                            if (rating != null) ...[
                              ...List.generate(5, (index) {
                                return WidgetSpan(
                                  child: Icon(
                                    index < rating!
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 14.r,
                                    color: Colors.amber,
                                  ),
                                );
                              }),
                              TextSpan(
                                text: ' ($rating.0) \n',
                              ),
                            ],
                            WidgetSpan(
                              child: Icon(
                                Icons.directions_car_filled,
                                size: 14.r,
                                color: AppColors.pdfButtonColor,
                              ),
                            ),
                            TextSpan(
                              text: ' $subTitle',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!isHistory) ...[
              SizedBox(height: 16.h),
              CustomContainer(
                onTap: onTap,
                paddingAll: 10.r,
                radiusAll: 100.r,
                width: double.infinity,
                color: buttonColor ?? AppColors.cancelButtonColor,
                child: CustomText(
                  text: buttonLabel ?? '',
                  color: Colors.white,
                  fontsize: 16.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
