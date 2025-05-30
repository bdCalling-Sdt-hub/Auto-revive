import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../controllers/mechanic_controller/mechanic_on_site_controller/booking_all_filters_controller.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../widgets/custom_app_bar.dart';

class TowTruckDetailsScreen extends StatefulWidget {
  const TowTruckDetailsScreen({super.key});

  @override
  State<TowTruckDetailsScreen> createState() => _TowTruckDetailsScreenState();
}

class _TowTruckDetailsScreenState extends State<TowTruckDetailsScreen> {


  MechanicBookingAllFiltersController mechanicBookingAllFiltersController = Get.put(MechanicBookingAllFiltersController());

  @override
  Widget build(BuildContext context) {
    Map routeData = GoRouterState.of(context).extra as Map;
    mechanicBookingAllFiltersController.getProvider(id: routeData['id']);
    return CustomScaffold(
      appBar: CustomAppBar(
          title: "${routeData["title"]}"),
      body: Column(
        children: [
          SizedBox(height: 44.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageAvatar(
                image: "${routeData["image"]}",
                radius: 44.r,
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: CustomText(
                      textAlign: TextAlign.start,
                      text: "${routeData["name"]}",
                      fontsize: 20.sp,
                      bottom: 6.h,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 120.w,
                          child: CustomText(
                            text: '${routeData["address"]}',
                          )),
                      // Icon(
                      //   Icons.star,
                      //   size: 16.r,
                      //   color: Colors.amber,
                      // ),
                      // CustomText(
                      //   text: ' 4.85',
                      // ),
                    ],
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.pushNamed(
                                AppRoutes.messageChatScreen, extra: {
                              "receiverId" : "${routeData["provideId"]}",
                              "name" : "${routeData["name"]}"
                            });
                          },
                          child: Assets.icons.detailsMessage.svg()),
                      SizedBox(width: 6.w),
                      GestureDetector(
                          onTap: () {
                            context.pushNamed(AppRoutes.mechanicMapScreen,
                                extra: {
                                  "name": routeData["name"],
                                  "address": routeData["address"],
                                  "rating": routeData["rating"],
                                  "lat": routeData["lat"],
                                  "log": routeData["log"],
                                  "image": routeData["image"]
                                });
                          },
                          child: Assets.icons.detailsLocation.svg()),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 44.w),
          Obx(()=>
             CustomContainer(
              paddingAll: 32.r,
              radiusAll: 16.r,
              color: AppColors.primaryColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle_rounded,
                        size: 14.r,
                        color: Colors.white,
                      ),
                      Flexible(
                        child: CustomText(
                          text: mechanicBookingAllFiltersController.provider.value.location ?? 'N/A',
                          color: Colors.white,
                          left: 2.w,
                          fontsize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle_rounded,
                        size: 14.r,
                        color: Colors.white,
                      ),
                      Flexible(
                        child: CustomText(
                            text: mechanicBookingAllFiltersController.provider.value.destination ?? 'N/A',
                            color: Colors.white,
                            left: 2.w,
                            fontsize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    text: 'Total Distance: ${mechanicBookingAllFiltersController.provider.value.totalDistance ?? 'N/A'} Miles',
                    color: Colors.white,
                    fontsize: 20.sp,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          CustomButton(title: 'Complete',
              onpress: () {
                mechanicBookingAllFiltersController.changeStatus(
                    status: 'confirmed',
                    jobId: "${routeData["id"]}",
                    isScreenBack: true,
                    context: context);



          }),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}
