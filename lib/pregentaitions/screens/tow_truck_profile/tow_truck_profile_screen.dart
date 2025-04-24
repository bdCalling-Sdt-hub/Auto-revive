import 'package:autorevive/core/app_constants/app_constants.dart';
import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/helpers/prefs_helper.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_profile_list_tile.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../global/custom_assets/assets.gen.dart';


class TowTruckProfileScreen extends StatefulWidget {
  const TowTruckProfileScreen({super.key});

  @override
  State<TowTruckProfileScreen> createState() => _TowTruckProfileScreenState();
}

class _TowTruckProfileScreenState extends State<TowTruckProfileScreen> {

  String userRole = "";

  @override
  void initState() {
    getLocalData();
    super.initState();
  }

  getLocalData()async{
    userRole = await PrefsHelper.getString(AppConstants.role);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  Assets.icons.logoSVG
                      .svg(color: AppColors.primaryColor, height: 50.h),
                  const Spacer(),
                  Assets.icons.timeProgress.svg(color: Colors.black),
                  SizedBox(width: 20.w),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.notificationsScreen);
                    },
                      child: Assets.icons.notificationIcon.svg(color: Colors.black)),
                ],
              ),
              CustomImageAvatar(
                radius: 50.r,
              ),
              CustomText(
                text: 'Bryan',
                fontsize: 24.sp,
              ),
              SizedBox(height: 24.h),
              CustomProfileListTile(
                  title: 'Profile Information',
                  icon: Assets.icons.profileInfo.svg(),
                  onTap: () {
                   userRole == "Customer" ? context.pushNamed(AppRoutes.personalInfoCustomerScreen) :userRole == "Mechanic or automotive shop" ?  context.pushNamed(AppRoutes.mechanicProfileInformationScreen) :
                    context.pushNamed(AppRoutes.profileDetailsScreen);
                  }),


              CustomProfileListTile(
                  title: 'Earnings',
                  icon: Assets.icons.earnings.svg(),
                  onTap: () {
                    context.pushNamed(AppRoutes.earningScreen);

                  }),


              CustomProfileListTile(
                  title: 'Admin Support',
                  icon: Assets.icons.support.svg(),
                  onTap: () {}),


              CustomProfileListTile(
                  title: 'Settings ',
                  icon: Assets.icons.settings.svg(),
                  onTap: () {
                    context.pushNamed(AppRoutes.settingsScreen);


                  }),


              CustomProfileListTile(
                  title: 'Logout',
                  icon: Assets.icons.logout.svg(),
                 onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                textAlign: TextAlign.center,
                                  text: 'Log Out', fontsize: 20.sp,  color: AppColors.logColor,
                                fontWeight: FontWeight.w400),
                              SizedBox(height: 10.h),
                              Divider(thickness: 1, color: Colors.grey.withOpacity(0.4)),
                              SizedBox(height: 24.h),
                              Text(
                                "Are you sure you want to sure\nLogout?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Cancel Button
                                  SizedBox(
                                    width: 110.w,
                                    height: 44.h,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.r),
                                        ),
                                        side: BorderSide(color: Colors.pinkAccent, width: 1.5),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Logout Button
                                  SizedBox(
                                    width: 110.w,
                                    height: 44.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.r),
                                        ),
                                      ),
                                      onPressed: () {
                                        context.go(AppRoutes.roleScreen);
                                      },
                                      child: Text(
                                        "Logout",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );



                },)

            ],
          ),
        ],
      ),
    );
  }
}
