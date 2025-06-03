import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';

class EarningHistoryCard extends StatelessWidget {
  final String userName;
  final String transactionId;
  final String date;
  final String amount;
  final String image;

  const EarningHistoryCard({
    Key? key,
    required this.userName,
    required this.transactionId,
    required this.date,
    required this.amount,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      verticalMargin: 5.h,
      paddingAll: 10.r,
      radiusAll: 16.r,
      linearColors: const [
        Color(0xff407BFF),
        Color(0xff3C2E93),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 13)
      ],
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CustomImageAvatar(
          image: image,
        ),
        title: CustomText(
          text: userName,
          color: Colors.white,
          textAlign: TextAlign.start,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Tr. ID: $transactionId\n$date',
              color: Colors.white,
              textAlign: TextAlign.start,
              fontsize: 10.sp,
            ),
          ],
        ),


        trailing: CustomText(
          right: 24.w,
          text: '\$ $amount',
          color: Colors.white,
          textAlign: TextAlign.start,
          fontsize: 28.sp,
        ),
      ),
    );
  }
}
