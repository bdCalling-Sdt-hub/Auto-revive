import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MechanicCompleteDetailsScreen extends StatelessWidget {
  const MechanicCompleteDetailsScreen({super.key});

  final List<Map<String, dynamic>> services = const [
    {"title": "Diesel Engine Repair", "price": 27, "checked": true},
    {"title": "Gasoline Engine Repair", "price": 27, "checked": true},
    {"title": "Semi-Truck Repair", "price": 27, "checked": false},
    {"title": "Trailer Repair", "price": 27, "checked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          maxline: 2,
          text: "Details",
          fontsize: 20.sp,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomImageAvatar(image: '', radius: 44.r),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'David Bryan',
                    fontsize: 20.sp,
                    bottom: 6.h,
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'New York, USA '),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      Assets.icons.detailsMessage.svg(),
                      SizedBox(width: 6.w),
                      Assets.icons.detailsLocation.svg(),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 26.h),

          // /// Services UI Section
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 16.w),
          //   padding: EdgeInsets.symmetric(vertical: 10.h),
          //   decoration: BoxDecoration(
          //     color: Colors.black,
          //     borderRadius: BorderRadius.circular(10.r),
          //   ),
          //   child: Column(
          //     children: services.map((service) {
          //       return Container(
          //         padding:
          //         EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          //         decoration: BoxDecoration(
          //           border: Border(
          //             bottom: BorderSide(color: Colors.white12, width: 1),
          //           ),
          //         ),
          //         child: Row(
          //           children: [
          //             Container(
          //               width: 20.w,
          //               height: 20.h,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(4.r),
          //                 color: service["checked"]
          //                     ? Colors.blue
          //                     : Colors.transparent,
          //                 border: Border.all(color: Colors.blue, width: 2),
          //               ),
          //             ),
          //             SizedBox(width: 12.w),
          //             Expanded(
          //               child: CustomText(
          //                 text: service["title"],
          //                 fontsize: 14.sp,
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.white.withOpacity(
          //                     service["checked"] ? 1 : 0.4), // faded if not selected
          //               ),
          //             ),
          //             CustomText(
          //               text: "\$ ${service["price"]}",
          //               fontsize: 14.sp,
          //               fontWeight: FontWeight.w500,
          //               color: Colors.white.withOpacity(
          //                   service["checked"] ? 1 : 0.4),
          //             ),
          //           ],
          //         ),
          //       );
          //     }).toList(),
          //   ),
          // ),

          const Spacer(),
          CustomButton(title: 'Complete', onpress: () {}),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
