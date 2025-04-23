import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerMapScreen extends StatefulWidget {
  @override
  _CustomerMapScreenState createState() => _CustomerMapScreenState();
}

class _CustomerMapScreenState extends State<CustomerMapScreen> {

  final LatLng _center = const LatLng(37.7749, -122.4194);
  Set<Circle> _circles = {};
  bool _isFilterVisible = false;
  double _distance = 4; // Default distance in miles

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _updateCircle(_distance);
  }

  void _updateCircle(double miles) {
    final radiusInMeters = miles * 1609.34;
    setState(() {
      _circles = {
        Circle(
          circleId: const CircleId('radius'),
          center: _center,
          radius: radiusInMeters,
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: AppColors.primaryColor,
          strokeWidth: 2,
        ),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    Map routerData = GoRouterState.of(context).extra as Map;
    return Scaffold(
      appBar: CustomAppBar(
        title: routerData["title"].toString(),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isFilterVisible = !_isFilterVisible;
              });
            },
            child: Assets.icons.filterIcons.svg(),
          ),
          SizedBox(width: 20.w),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            circles: _circles,
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
                    child: Icon(Icons.search, color: Colors.white,),
                  ),
                ],
              ),
            ),
          ),

          // Filter Side Panel
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 0,
            bottom: 0,
            right: _isFilterVisible ? 0 : -250.w,
            child: Container(
              width: 250.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10.r),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CustomText(text: "Filter", fontsize: 22.h, color: AppColors.primaryColor),
                  ),
                  SizedBox(height: 20.h),

                  CustomText(text: "Miles From Me", fontsize: 20.h, color: AppColors.textColor151515),


                  SizedBox(height: 10.h),



                  Slider(
                    value: _distance,
                    min: 1,
                    max: 5,
                    divisions: 5,
                    label: "${_distance.toInt()}",
                    activeColor: AppColors.primaryColor,
                    inactiveColor: Colors.grey.shade300,
                    onChanged: (value) {
                      setState(() {
                        _distance = value;
                      });
                    },
                  ),




                  Center(child: CustomText(text: "Maximum", fontsize: 12.h, color: const Color(0xff262626), bottom: 4.h)),

                  Center(
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor,),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${_distance.toInt()}",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  const Spacer(),

                  CustomButton(title: "Apply", onpress: () {
                    setState(() {
                      _isFilterVisible = false;
                    });
                  },)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
