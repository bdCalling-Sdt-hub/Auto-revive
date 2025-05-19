import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/notifications_controller.dart';
import '../../widgets/custom_loader.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  NotificationsController notificationsController = Get.put(NotificationsController());


  @override
  void initState() {
    notificationsController.getNotifications();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Obx(() =>
      notificationsController.notificationLoading.value ? const CustomLoader() :
      notificationsController.notifications.isEmpty ? CustomText(text: "No Notification Found!") :
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: ListView.builder(
            itemCount: notificationsController.notifications.length,
            itemBuilder: (context, index)  {
              var notification = notificationsController.notifications[index];
              return NotificationTile(
                title: notification.title,
                subtitle: notification.message,
                time: notification.createdAt,
                iconAsset: 'assets/icons/notification.svg',
              );
            },
          ),
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final DateTime time;
  final String iconAsset;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 12.w),
          width: 50.w,
          height: 50.h,
          decoration: const BoxDecoration(
            color: AppColors.borderColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              iconAsset,
              width: 24.w,
              height: 24.h,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: title,fontsize: 14.sp,color: AppColors.textColor151515),
              SizedBox(height: 8.h),
              CustomText(text: subtitle,fontsize: 12.sp,color: AppColors.textColor151515),
              SizedBox(height: 2.h),
              CustomText(text:_formatTime(time),fontsize: 12.sp,color: AppColors.textColor151515,),
              SizedBox(height: 15.sp,)
            ],
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour < 12 ? "am" : "pm"}";
  }


}
