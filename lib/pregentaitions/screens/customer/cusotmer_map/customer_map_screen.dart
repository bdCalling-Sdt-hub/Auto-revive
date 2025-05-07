import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../widgets/custom_container.dart';
import '../../../widgets/custom_slider.dart';

class CustomerMapScreen extends StatefulWidget {
  const CustomerMapScreen({super.key});

  @override
  _CustomerMapScreenState createState() => _CustomerMapScreenState();
}

class _CustomerMapScreenState extends State<CustomerMapScreen> {
  double _miles = 4;

  final CustomerMapController customerMapController =
  Get.put(CustomerMapController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await customerMapController.setInitialLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map routerData = GoRouterState.of(context).extra as Map;

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

              return GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: controller.initialCameraPosition!,
                circles: controller.circles,
                onMapCreated: (GoogleMapController mapCtrl) {
                  controller.mapController = mapCtrl;
                },
              );
            },
          ),
          Positioned(
            top: 20,
            left: 15,
            right: 15,
            child: Container(
              padding: EdgeInsets.only(left: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [BoxShadow(blurRadius: 10.r, color: Colors.black12)],
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Color(0xff9D9D9D)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
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
                  activeColor: AppColors.primaryShade300,
                  inactiveColor: AppColors.switchColor,
                  thumbColor: Colors.grey.shade300,
                  value: _miles,
                  onChanged: (val) {
                    setState(() => _miles = val);
                  },
                ),
                CustomText(text: 'Maximum', fontsize: 12.sp, bottom: 4.h),
                CustomContainer(
                  alignment: Alignment.center,
                  radiusAll: 12.r,
                  width: 95.w,
                  height: 42.h,
                  bordersColor: AppColors.primaryShade300,
                  child: CustomText(
                    text: _miles.toInt().toString(),
                    fontsize: 16.sp,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    customerMapController.updateCircle(_miles);
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
}

class CustomerMapController extends GetxController {
  GoogleMapController? mapController;
  CameraPosition? initialCameraPosition;
  LatLng center = const LatLng(0, 0);

  double miles = 5.0;
  Set<Circle> circles = {};
  bool isLoading = true;

  void updateCircle(double miles) {
    final radiusInMeters = miles * 1609.34;

    circles = {
      Circle(
        circleId: const CircleId('radius'),
        center: center,
        radius: radiusInMeters,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ),
    };

    update(); // Notifies GetBuilder
  }

  void updateCenter(LatLng newCenter) {
    center = newCenter;
    update();
  }

  Future<void> setInitialLocation() async {

    LocationPermission permission = await Geolocator.checkPermission();

    debugPrint("========================permission : $permission");

    try {
      final position = await determinePosition();
      debugPrint('Got location: ${position.latitude}, ${position.longitude}');

      center = LatLng(position.latitude, position.longitude);
      initialCameraPosition = CameraPosition(target: center, zoom: 14.0);
    } catch (e) {
      debugPrint('Location error: $e');

      // Fallback to Dhaka if real location fails
      center = const LatLng(23.8103, 90.4125);
      initialCameraPosition = CameraPosition(target: center, zoom: 12.0);
      Get.snackbar("Location Error", "Using fallback location in Dhaka.");
    }

    updateCircle(miles);
    isLoading = false;
    update();
  }


  Future<Position> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
