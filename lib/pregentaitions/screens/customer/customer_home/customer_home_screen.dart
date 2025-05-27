import 'package:autorevive/controllers/live_location_change_controller.dart';
import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../controllers/current_location_controller.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_text.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  CurrentLocationController controller = Get.put(CurrentLocationController());
  LiveLocationChangeController liveLocationChangeController = Get.put(LiveLocationChangeController());
  SocketServices socketServices = SocketServices();


  @override
  void initState() {
    requestNotificationPermission();
    controller.getCurrentLocation();
    liveLocationChangeController.listenToLocationChanges();

    super.initState();
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Assets.images.customerHomeScreenImage.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.7),
              colorBlendMode: BlendMode.darken),

          // Bottom elevation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 44.h),
                    Row(
                      children: [
                        Assets.icons.logoSVG
                            .svg(color: Colors.white, height: 50.h),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoutes.progressScreen);
                            },
                            child: Assets.icons.timeProgress.svg()),
                        SizedBox(width: 20.w),
                        GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoutes.notificationsScreen);
                            },
                            child: Assets.icons.notificationIcon.svg())
                      ],
                    ),
                    SizedBox(height: 90.h),
                    Assets.icons.logoSVG.svg(color: Colors.white),
                    SizedBox(height: 27.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          text: "Find the best way",
                          fontsize: 35.h,
                          bottom: 24.h,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    CustomText(
                        text:
                            "Find a mechanic or tow truck easily with our app—quick, reliable service whenever you need it, wherever you are.",
                        maxline: 3,
                        fontsize: 18.h,
                        textAlign: TextAlign.start,
                        bottom: 48.h,
                        color: Colors.white),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.customerMechanicScreen);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 8.h),
                          child: Row(
                            children: [
                              CustomText(text: "Mechanic", color: Colors.black),
                              const Spacer(),
                              const Icon(Icons.keyboard_arrow_right_rounded)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () {
                        controller.isLoading.value;
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(AppRoutes.customerSelectCarScreen,
                                extra: {
                                  "title": "Tow Truck",
                                  "address" : "${controller.address.value}"
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 8.h),
                              child: Row(
                                children: [
                                  CustomText(
                                      text: "Tow truck", color: Colors.black),
                                  const Spacer(),
                                  const Icon(Icons.keyboard_arrow_right_rounded)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



