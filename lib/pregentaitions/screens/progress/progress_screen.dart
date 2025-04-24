import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/booking_card_customer.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    int rating = 4;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: CustomText(
          text: "Progress job",
          fontsize: 20.sp,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.all(8.r),
              itemBuilder: (context, index) {
                return BookingCardCustomer(
                  isNextPay: true,
                  buttonLabel: 'Pay Now',
                  buttonColor: AppColors.primaryShade300,
                  onTapDetails: () {
                    context.pushNamed(AppRoutes.towTruckDetailsScreen);
                  },
                  onTap: () {
                    context.pushNamed(AppRoutes.customerBookingDetailsScreen, extra: {
                      "title" : "Details"
                    });
                  },
                  title: r'Price: $108',
                  name: 'David Bryan',
                  certificates: const ["ASE", "OEM"],
                  rating: rating,
                  status: 'On-going',
                  image: '',
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
