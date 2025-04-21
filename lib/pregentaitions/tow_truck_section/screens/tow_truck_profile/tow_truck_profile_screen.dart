import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_profile_list_tile.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../global/custom_assets/assets.gen.dart';

class TowTruckProfileScreen extends StatelessWidget {
  const TowTruckProfileScreen({super.key});

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
                  Assets.icons.notificationIcon.svg(color: Colors.black),
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
                  onTap: () {}),


              CustomProfileListTile(
                  title: 'Logout',
                  icon: Assets.icons.logout.svg(),
                  onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
