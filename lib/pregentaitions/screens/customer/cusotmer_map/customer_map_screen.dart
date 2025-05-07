import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../widgets/custom_container.dart';
import '../../../widgets/custom_slider.dart';

class CustomerMapScreen extends StatefulWidget {
  @override
  _CustomerMapScreenState createState() => _CustomerMapScreenState();
}

class _CustomerMapScreenState extends State<CustomerMapScreen> {

  final LatLng _center = const LatLng(37.7749, -122.4194);
  Set<Circle> _circles = {};
  double _miles = 4;

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _updateCircle(_miles);
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
          Builder(
              builder: (context) {
                return GestureDetector(
                    onTap: (){
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Assets.icons.menu.svg());
              }
          ),

          SizedBox(width: 24.w)
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


        ],
      ),


      endDrawer: Drawer(
        backgroundColor: AppColors.bgColorWhite,
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.fromLTRB(16.w,60.h,16.w,8.h),
            child: Column(
              children: [
                CustomText(text: 'Filter',color: AppColors.primaryColor,fontsize: 22.sp,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(text: 'Miles From Me',fontsize: 20.sp,left: 16.w,top: 16.h,)),

                CustomSlider(
                  activeColor: AppColors.primaryShade300,
                  inactiveColor: AppColors.switchColor,
                  thumbColor: Colors.grey.shade300,
                  value: _miles,
                  onChanged: (val){
                    _miles = val;
                    setState(() {

                    });
                  },
                ),
                CustomText(
                    text: 'Maximum',
                    fontsize: 12.sp,
                    bottom: 4.h),




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
                  onTap: (){
                    context.pop();
                  },
                  child: CustomContainer(
                    color: AppColors.primaryShade300,
                    paddingAll: 10.r,
                    radiusAll: 100.r,
                    width: double.infinity,
                    bordersColor: Colors.red,
                    child: CustomText(text: 'Apply',color: Colors.white,),
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
