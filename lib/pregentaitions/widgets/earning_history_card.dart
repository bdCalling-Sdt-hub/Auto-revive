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
  final String status;

  const EarningHistoryCard({
    Key? key,
    required this.userName,
    required this.transactionId,
    required this.date,
    required this.amount,
    required this.image,
    required this.status,
  }) : super(key: key);


  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'STATUS.PENDING':
        return Colors.redAccent;
      case 'STATUS.SUCCESS':
        return Colors.lightGreenAccent;
      default:
        return Colors.grey;
    }
  }


  String _getFormattedStatus(String status) {
    if (status.contains('.')) {
      return status.split('.').last.toLowerCase();
    }
    return status.toLowerCase();
  }

  // String _getFormattedStatus(String status) {
  //   if (status.contains('.')) {
  //     final parts = status.split('.');
  //     return parts.last[0].toUpperCase() + parts.last.substring(1).toLowerCase();
  //   }
  //   return status[0].toUpperCase() + status.substring(1).toLowerCase();
  // }


  @override
  Widget build(BuildContext context) {
    final formattedStatus = _getFormattedStatus(status);
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
        trailing: SizedBox(
          width: 150.w,
          child: Column(
            children: [
              CustomText(
                right: 24.w,
                text: '\$ $amount',
                color: Colors.white,
                textAlign: TextAlign.start,
                fontsize: 28.sp,
              ),
              CustomText(
                text: formattedStatus,
                color: _getStatusColor(status),
                textAlign: TextAlign.start,
                fontsize: 12.sp,
              ),
            ],
          ),
        ),

      ),
    );
  }
}
