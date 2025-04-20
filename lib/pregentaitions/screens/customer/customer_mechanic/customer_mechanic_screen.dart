import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomerMechanicScreen extends StatelessWidget {
  const CustomerMechanicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Mechanic"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 57.h),
            CustomButton(title: "On Site", onpress: () {
              context.pushNamed(AppRoutes.customerSelectCarScreen);
            }),
            SizedBox(height: 11.h),
            CustomButton(title: "In-Shop", onpress: () {
              context.pushNamed(AppRoutes.customerSelectCarScreen);
            }),

            SizedBox(height: 87.h),

            CustomText(
                text: "Find a mobile mechanic (On-Site)",
                color: AppColors.primaryColor,
                bottom: 22.h),
            CustomText(
                text:
                    "Need urgent repairs on the road? Our mobile mechanics come to you, whether you're stranded on the highway, at home, or at work. From battery jump-starts to engine swaps, we provide quick and reliable service to get you back on the road.",
                color: Colors.black,
                maxline: 10,
                bottom: 22.h),





            CustomText(
                text: "Find a repair shop (In-shop)",
                color: AppColors.primaryColor,
                bottom: 22.h),
            CustomText(
                text:
                "For major repairs and detailed diagnostics, visit one of our trusted garages. Our expert mechanics use advanced tools to handle engine repairs, brake fixes, and more. Enjoy quality service at competitive prices with guaranteed satisfaction. Book your appointment today for hassle-free car care! ",
                color: Colors.black,
                maxline: 10,
                bottom: 22.h),





          ],
        ),
      ),
    );
  }
}
