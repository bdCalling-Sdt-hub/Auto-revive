
import 'dart:async';
import 'dart:math';

import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:autorevive/controllers/customer/customer_map_controller.dart';
import '../../../../controllers/customer/customer_home_controller.dart';
import '../../../../controllers/mechanic_controller/mechanic_job_controller.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/custom_slider.dart';

class CustomerMapScreen extends StatefulWidget {
  const CustomerMapScreen({super.key});

  @override
  _CustomerMapScreenState createState() => _CustomerMapScreenState();
}

class _CustomerMapScreenState extends State<CustomerMapScreen> {



  final CustomerMapController customerMapController = Get.put(CustomerMapController());
  CustomerHomeController customerHomeController = Get.find<CustomerHomeController>();
  final MechanicJobController mechanicJobController = Get.find<MechanicJobController>();

  double _miles = 5;
  @override
  void initState() {
    super.initState();


    mechanicJobController.settingRadiusLimits().then((_) {
      final min = mechanicJobController.radiusLimits.value.value?.min ?? 0;
      setState(() {
        _miles = min.toDouble();
      });
    });

    Future.delayed(Duration.zero, () async {
      await customerMapController.setInitialLocation();
    });


  }


  @override
  Widget build(BuildContext context) {
    final radiusLimits = mechanicJobController.radiusLimits.value.value;
    final double min = radiusLimits?.min?.toDouble() ?? 0;
    final double max = radiusLimits?.max?.toDouble() ?? 100;

    final extra = GoRouterState.of(context).extra;
    if (extra == null || extra is! Map) {
      return const Center(child: Text('Something went wrong Please go back'));
    }
    final Map routerData = extra;

    customerMapController.fetchMechanicWithRadius(radius: _miles.toString(), target: "${routerData["title"]}");


    print("================================================   : ${customerMapController.markers}");

    return Scaffold(
      appBar: CustomAppBar(
        title: routerData["title"].toString(),
        actions: [
          Builder(builder: (context) {
            return GestureDetector(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: Assets.icons.menu.svg(),
            );
          }),
          SizedBox(width: 24.w),
        ],
      ),
      body: Stack(
        children: [
          GetBuilder<CustomerMapController>(
            builder: (controller) {
              if (controller.isLoading ||
                  controller.initialCameraPosition == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return GetBuilder<CustomerMapController>(
                builder: (controller) {
                  return  GoogleMap(
                    myLocationEnabled: true,
                    initialCameraPosition: controller.initialCameraPosition!,
                    circles: controller.circles,
                    markers: customerMapController.markers,
                    onMapCreated: (GoogleMapController mapCtrl) {
                      controller.mapController = mapCtrl;
                      // controller.isMapReady = true;
                    },
                  );
                },
              );
            },
          ),



          Obx(() {
            return _buildStatusCard(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customerMapController.mechanicLoading.value
                      ? SizedBox(
                          height: 90.h,
                          width: 90.w,
                          child: const CircularProgressIndicator(
                            value: null, // loading animation
                            strokeWidth: 8,
                            backgroundColor: AppColors.primaryColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xfff5f5f5)),
                          ),
                        )
                      : customerMapController.mechanic.isEmpty
                          ? Assets.icons.notFound.svg(height: 90.h)
                          : Assets.icons.logoSVG.svg(height: 90.h),
                  customerMapController.mechanicLoading.value
                      ? SizedBox(height: 70.h)
                      : CustomText(
                          text: customerMapController.mechanic.isEmpty
                              ? "Could Not Find Any One!"
                              : "Mechanic's Available (${customerMapController.mechanic.length})",
                          fontsize: 20.h,
                          bottom: 10.h,
                          color: customerMapController.mechanic.isEmpty
                              ? Colors.red
                              : Colors.black,
                          top: 5.h),
                  customerMapController.mechanicLoading.value
                      ? Obx(() =>
                         Text(
                            'Searching${'.' * customerMapController.dotCount.value}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                      )
                      : CustomButton(
                          title: customerMapController.mechanic.isEmpty
                              ? "Try Again"
                              : "Submit",
                          onpress: () {

                            print("-----------------------------------------------------  ${routerData["destCoordinates"]}");

                            List<String> carModelList = [];

                            for(var car in customerMapController.mechanic){
                              carModelList.add(car.id.toString());
                            }
                            customerMapController.mechanic.isEmpty
                                ? customerMapController.fetchMechanicWithRadius(radius: "$_miles", target: routerData["title"])
                                : customerHomeController.postJob(
                                    context: context,
                                    time: "${routerData["time"]}",
                                    date: "${routerData["date"]}",
                                    carModelId: routerData["carModelId"],
                                    platForm: routerData["title"],
                                    targets: carModelList,
                                    coordinates: routerData["coordinates"],
                                    destCoordinates: routerData["destCoordinates"]
                            );
                          })
                ],
              ),
            );
          }),
        ],
      ),



      endDrawer: Drawer(
        backgroundColor: AppColors.bgColorWhite,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 8.h),
            child: Column(
              children: [
                CustomText(
                  text: 'Filter',
                  color: AppColors.primaryColor,
                  fontsize: 22.sp,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'Miles From Me',
                    fontsize: 20.sp,
                    left: 16.w,
                    top: 16.h,
                  ),
                ),

                CustomSlider(
                  value: _miles,
                  min: min,
                  max: max,
                  activeColor: AppColors.primaryColor,
                  onChanged: (val) {
                    setState(() {
                      _miles = val;
                    });
                  },
                ),
                CustomText(
                    text: 'Max: ${max.toInt()}',
                    fontsize: 12.sp,
                    color: Colors.black87,
                    bottom: 4.h),
                CustomContainer(
                  alignment: Alignment.center,
                  radiusAll: 12.r,
                  width: 95.w,
                  height: 42.h,
                  bordersColor: AppColors.primaryShade300,
                  child: CustomText(
                    text: _miles.toInt().toString(),
                    color: Colors.black87,
                    fontsize: 16.sp,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    customerMapController.updateCircle(_miles);
                    customerMapController.mechanic.clear();
                    customerMapController.fetchMechanicWithRadius( target: "${routerData["title"]}",
                        radius: "${_miles}");
                    context.pop();
                  },
                  child: CustomContainer(
                    color: AppColors.primaryShade300,
                    paddingAll: 10.r,
                    radiusAll: 100.r,
                    width: double.infinity,
                    bordersColor: Colors.red,
                    child: CustomText(
                      text: 'Apply',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard({required Widget content}) {
    return Positioned(
      bottom: 40,
      left: 40,
      right: 40,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Center(child: content),
        ),
      ),
    );
  }
}
