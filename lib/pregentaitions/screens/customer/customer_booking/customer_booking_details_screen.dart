import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/cachanetwork_image.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_two_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../widgets/custom_text.dart';

class CustomerBookingDetailsScreen extends StatelessWidget {
   CustomerBookingDetailsScreen({super.key});

  final List certificateList = ["ASE", "OEM", "DOT"];

  @override
  Widget build(BuildContext context) {
    Map routeData = GoRouterState.of(context).extra as Map;
    return Scaffold(
      appBar:  CustomAppBar(title: "${routeData["title"]}"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomNetworkImage(
                    imageUrl: "https://randomuser.me/api/portraits/men/20.jpg",
                    boxShape: BoxShape.circle,
                    height: 110.h,
                    width: 110.w,
                    border: Border.all(color: AppColors.primaryColor)),
                SizedBox(width: 18.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                            text: "David Bryan",
                            color: Colors.black,
                            right: 30.w,
                            fontsize: 22.h),


                        Container(decoration: BoxDecoration(
                          color: AppColors.primaryShade300,
                          borderRadius: BorderRadius.circular(8.r)
                        ),child: Padding(
                          padding:  EdgeInsets.all(4.r),
                          child: Icon(Icons.location_on, color: Colors.white, size: 16.r),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(text: "New York, USA", color: Colors.black),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 6.w),
                            height: 13.h,
                            width: 1.w,
                            color: Colors.grey),
                        Icon(Icons.star, color: Colors.amber, size: 20.h),
                        CustomText(
                            text: "4.10", fontsize: 12.h, color: Colors.black)
                      ],
                    ),
                    SizedBox(height: 8.h),


                    routeData["title"] ==  "Complete" ?
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 6.h,
                      children:
                      List.generate(certificateList.length, (index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFE6E6),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: CustomText(
                            text: certificateList[index].toString(),
                            fontsize: 10.sp,
                          ),
                        );
                      }),
                    ) :


                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryShade300,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 6.w),
                            child: Row(
                              children: [
                                Assets.icons.profileIcon.svg(),
                                SizedBox(width: 10.w),
                                CustomText(
                                    text: "Profile",
                                    color: Colors.white,
                                    fontsize: 12.h),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryShade300,
                              borderRadius: BorderRadius.circular(8.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 6.w),
                            child: Row(
                              children: [
                                Assets.icons.mail.svg(),
                                SizedBox(width: 10.w),
                                CustomText(
                                    text: "Message",
                                    color: Colors.white,
                                    fontsize: 12.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            CustomText(
                text: routeData["title"] ==  "Complete" ? "Price need to pay..." : "Problem which need to solve that's price",
                color: Colors.black,
                fontsize: 20.h,
                maxline: 2,
                textAlign: TextAlign.start,
                bottom: 8.h,
                top: 30.h),




            Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: AppColors.primaryShade300,
              ),
              child: Row(
                children: [

                  routeData["title"] ==  "Complete" ? const SizedBox()  :
                  Container(
                    margin: EdgeInsets.all(4.r),
                    width: 157.w,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: CustomText(text: "Total Price", fontsize: 25.h, color: AppColors.primaryShade300),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: CustomText(
                        text: r"$ 107",
                        fontsize: 48.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 11.h),

            routeData["title"] ==  "Complete" ? const SizedBox()  : RepairListWidget(),


           const Spacer(),

            routeData["title"] ==  "Complete" ?
            CustomButton(title: "Pay Now", onpress: () {

            })  :
            
            CustomTwoButon(
              width: 163.w,
              btnNameList: const ["Pending", "Cancel"],
              rightBtnOnTap: () {

              },
              leftBtnOnTap: () {
                context.pushNamed(AppRoutes.customerBookingCancelScreen);
              },
            ),

            SizedBox(height: 40.h),

          ],
        ),
      ),
    );
  }
}




class RepairListWidget extends StatelessWidget {
  final List<String> services = [
    "Diesel Engine Repair",
    "Gasoline Engine Repair",
    "Semi-Truck Repair",
    "Trailer Repair",

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 22.w),
      height: 317.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primaryShade300, width: 0.4),
      ),
      child: Scrollbar(
        thickness: 4.w,
        radius: Radius.circular(4.r),
        child: ListView.separated(
          padding: EdgeInsets.all(8.w),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:  EdgeInsets.only(top: index == 0 ? 22.h : 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 16.w,
                        height: 16.w,
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryShade300,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      CustomText(text: services[index], color: Colors.black),

                    ],
                  ),

                  CustomText(text: r"$ 27", right: 22.w, color: Colors.black),


                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
        ),
      ),
    );
  }
}
