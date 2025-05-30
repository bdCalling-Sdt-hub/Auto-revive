import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../controllers/mechanic_controller/mechanic_on_site_controller/booking_all_filters_controller.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../../services/api_constants.dart';
import '../../../../widgets/custom_loader.dart';

class MechanicCompleteDetailsScreen extends StatefulWidget {
   const MechanicCompleteDetailsScreen({super.key});

  @override
  State<MechanicCompleteDetailsScreen> createState() => _MechanicCompleteDetailsScreenState();
}

class _MechanicCompleteDetailsScreenState extends State<MechanicCompleteDetailsScreen> {

  MechanicBookingAllFiltersController mechanicBookingAllFiltersController = Get.put(MechanicBookingAllFiltersController());


  @override
  Widget build(BuildContext context) {
    Map routeData = GoRouterState.of(context).extra as Map;
    mechanicBookingAllFiltersController.getJobProcessComplete(jobProcessId: '${routeData["id"]}');
    return CustomScaffold(

      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          maxline: 2,
          text: "Details",
          fontsize: 20.sp,
        ),
      ),

      body: Obx( () {
        return Column(
          children: [
            SizedBox(height: 20.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageAvatar(
                    image: "${ApiConstants.imageBaseUrl}/${mechanicBookingAllFiltersController.jobProcessComplete.value.customerId?.profileImage ?? ''}",
                    radius: 44.r),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: mechanicBookingAllFiltersController.jobProcessComplete.value.customerId?.name ?? 'N/A',
                      fontsize: 20.sp,
                      bottom: 6.h,
                    ),
                    CustomText(
                      text: mechanicBookingAllFiltersController.jobProcessComplete.value.customerId?.address ?? 'N/A',
                      fontsize: 20.sp,
                      bottom: 6.h,
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                  AppRoutes.messageChatScreen, extra: {
                                "receiverId" : "${mechanicBookingAllFiltersController.jobProcessComplete.value.customerId?.id}",
                                "name" : "${mechanicBookingAllFiltersController.jobProcessComplete.value.customerId?.name}"
                              });
                            },
                            child: Assets.icons.detailsMessage.svg()),
                        SizedBox(width: 6.w),
                        GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoutes.mechanicMapScreen,
                                  extra: {
                                    "name":mechanicBookingAllFiltersController.jobProcessComplete.value.customerId?.name,
                                    "address": mechanicBookingAllFiltersController.jobProcessComplete.value.customerId?.address,
                                    "rating": routeData["rating"],
                                    "lat": routeData["lat"],
                                    "log": routeData["log"],
                                    "image": mechanicBookingAllFiltersController.jobProcessComplete.value.customerId?.profileImage
                                  });
                            },
                            child: Assets.icons.detailsLocation.svg()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Align(
              alignment: Alignment.topLeft,
              child: CustomText(
                textAlign: TextAlign.start,
                fontsize: 20.sp,
                color: AppColors.textColor151515,
                text: 'Problem(s) need to be solved',
              ),
            ),
            SizedBox(height: 18.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 22.w),
              height: 317.h,
              decoration: BoxDecoration(
                color: AppColors.bgColorWhite,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                    color: AppColors.primaryShade300, width: 0.4),
              ),
              child: Scrollbar(
                thickness: 4.w,
                radius: Radius.circular(4.r),
                child: Obx((){
                  if (mechanicBookingAllFiltersController.getJobProcessCompleteLoading.value) {
                    return const Center(child: CustomLoader());
                  }
                 return ListView.builder(
                    padding: EdgeInsets.all(8.w),
                    itemCount: mechanicBookingAllFiltersController.jobProcessComplete.value.services?.length,
                    itemBuilder: (context, index) {
                      var jobData = mechanicBookingAllFiltersController.jobProcessComplete.value.services?[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? 22.h : 12.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20.w,
                                  height: 20.h,
                                  margin: EdgeInsets.only(right: 9.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                                CustomText(
                                  fontsize: 13.sp,
                                  text: '${jobData?.service ?? 'N/A'}',
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            CustomText(
                              fontsize: 13.sp,
                              text: '\$ ${jobData?.amount ?? 'N/A'}',
                              right: 22.w,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                )

              ),
            ),
            SizedBox(height: 93.h),
            CustomButton(title: 'Complete',
                onpress: () {
                 context.pop();
                 context.pop();

            }),
            SizedBox(height: 20.h),
          ],
        );

      }
      ),
    );
  }
}
