import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/screens/message/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../tow_truck_profile/tow_truck_profile_screen.dart';
import '../tow_truck_bookings/tow_trucks_bookings_screen.dart';
import '../tow_truck_home/tow_truck_home_screen.dart';

class TowTruckBottomNavBar extends StatefulWidget {
  const TowTruckBottomNavBar({super.key});

  @override
  State<TowTruckBottomNavBar> createState() => TowTruckBottomNavBarState();
}

class TowTruckBottomNavBarState extends State<TowTruckBottomNavBar> {
  final List<Widget> screens = [
    const TowTruckHomeScreen(),
    const TowTrucksBookingsScreen(),
    UsersScreen(),
    const TowTruckProfileScreen(),

  ];

  int currentIndex = 0;

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;

    return Scaffold(
      extendBody: true,
      backgroundColor: currentIndex == 0 ? Colors.transparent : AppColors.bgColorWhite,
      body: screens[currentIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          height: sizeH * .07,
          margin: EdgeInsets.all(sizeH * .015),
          padding: EdgeInsets.all(sizeH * .01),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(sizeH * .05),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.r,
                spreadRadius: 1.r,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0),
              _buildNavItem(1),
              _buildNavItem(2),
              _buildNavItem(3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final sizeH = MediaQuery.sizeOf(context).height;
    bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          height: sizeH * .06,
          decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              shape: BoxShape.circle),
          child:  Padding(padding: EdgeInsets.all(6.r),
            child: index == 0
                ? Assets.icons.homeIcon
                .svg(color: isSelected ? Colors.black : Colors.white)
                : index == 1
                ? Assets.icons.carIcon
                .svg(color: isSelected ? Colors.black : Colors.white)
                : index == 2
                ? Assets.icons.message
                .svg(color: isSelected ? Colors.black : Colors.white)
                : Assets.icons.profile.svg(color: isSelected ? Colors.black : Colors.white),
          )
      ),
    );
  }
}
