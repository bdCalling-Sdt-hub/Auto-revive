import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

import '../../../../../controllers/mechanic_controller/mechanic_on_site_controller/booking_all_filters_controller.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../widgets/custom_app_bar.dart';

class MechanicBookingsDetailsScreen extends StatefulWidget {

  const MechanicBookingsDetailsScreen({super.key});

  @override
  State<MechanicBookingsDetailsScreen> createState() => _MechanicBookingsDetailsScreenState();
}

class _MechanicBookingsDetailsScreenState extends State<MechanicBookingsDetailsScreen> {


  MechanicBookingAllFiltersController mechanicBookingAllFiltersController = Get.put(MechanicBookingAllFiltersController());

  @override
  void initState() {
    mechanicBookingAllFiltersController.getAllService();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map routeData = GoRouterState.of(context).extra as Map;
    return Scaffold(
      appBar:  CustomAppBar(title: "${routeData["title"]}"),
      body: Column(
        children: [
          SizedBox(height: 20.w),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageAvatar(image: "${routeData["image"]}", radius: 44.r),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "${routeData["name"]}",
                          fontsize: 20.sp,
                          bottom: 6.h,
                        ),
                        CustomText(
                          text: "${routeData["address"]}",
                          fontsize: 20.sp,
                          bottom: 6.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      children: [
                        Assets.icons.detailsMessage.svg(),
                        SizedBox(width: 6.w),
                        GestureDetector
                          (
                          onTap: () {
                            context.pushNamed(AppRoutes.mechanicMapScreen);
                          },
                            child: Assets.icons.detailsLocation.svg()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 26.h),
          // ============>> Service Search and Selection <<============= //
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  fontsize: 20.sp,
                  color: AppColors.textColor151515,
                  text: 'Problem(s) need to be solved',
                ),
                SizedBox(height: 18.h),
                // Search Box
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Service Name',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.search, color: AppColors.primaryShade300),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                /// =====================================> Scrollable Services List ======================================>
                Container(
                  height: 300.h,
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryShade300),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Scrollbar(
                    thickness: 4,
                    radius: Radius.circular(8.r),
                    child: ListView(
                      children: [
                        _buildServiceTile(context, 'Diesel Engine Repair', '\$27',checked: true),
                  _buildServiceTile(context, 'Gasoline Engine Repair', '\$27',checked: true),
                  _buildServiceTile(context, 'Semi-Truck Repair', '\$27',checked: true),
                  _buildServiceTile(context, 'Trailer Repair', '\$27',checked: true),
                  _buildServiceTile(context, 'RV Repair', '\$23', checked: true),
                  _buildServiceTile(context, 'Brake Systems', '', isEnabled: true),
                  _buildServiceTile(context, 'Welding/Fabrication', '', isEnabled: true),
                  _buildServiceTile(context, 'Other', '', isEnabled: true),
                  ],
                ),

          ),
                ),
              ],
            ),
          ),
          const Spacer(),
          CustomButton(title: 'Submit',
              onpress: () {
                context.pushNamed(AppRoutes.mechanicCompleteDetailsScreen);


              }),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildServiceTile(BuildContext context, String name, String price, {bool checked = false, bool isEnabled = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.blue, // Unchecked box color (for disabled)
            ),
            child: Checkbox(
              value: checked,
              onChanged: isEnabled ? (v) {

              } : null,
              activeColor: AppColors.primaryColor, // Checked box color
              checkColor: AppColors.primaryColor, // Tick mark color
              side: const BorderSide(
                color: AppColors.primaryColor, // Border color
                width: 2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isEnabled ? Colors.black : Colors.grey,
                decoration: isEnabled ? null : TextDecoration.lineThrough,
              ),
            ),
          ),
          if (price.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: checked ? Colors.grey.shade300 : Colors.transparent,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(price),
            ),
        ],
      ),
    );
  }

}

