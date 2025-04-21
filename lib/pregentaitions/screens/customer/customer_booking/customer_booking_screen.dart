import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/booking_card_widget.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/booking_card_customer.dart';

class CustomerBookingScreen extends StatefulWidget {
  const CustomerBookingScreen({super.key});

  @override
  State<CustomerBookingScreen> createState() => _CustomerBookingScreenState();
}

class _CustomerBookingScreenState extends State<CustomerBookingScreen> {
  @override
  Widget build(BuildContext context) {
    int rating = 4;
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: CustomText(
            maxline: 2,
            text: "Bookings",
            fontsize: 20.sp,
          ),
          bottom: TabBar(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            labelStyle: TextStyle(fontSize: 12.sp),
            dividerHeight: 0.5,
            dividerColor: AppColors.primaryShade300,
            labelColor: AppColors.primaryShade300,
            unselectedLabelColor: AppColors.primaryShade300,
            indicatorColor: AppColors.primaryShade300,
            tabs: const [
              Tab(
                text: 'Requested',
              ),
              Tab(text: 'Next Pay'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            /// Requested Tab
            ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              itemBuilder: (context, index) {
                return BookingCardCustomer(
                  buttonLabel: 'Cancel',
                  onTapDetails: () {
                    context.pushNamed(AppRoutes.towTruckDetailsScreen);
                  },
                  certificates: const ["ASE", "OEM"],
                  onTap: (){
                    context.pushNamed(AppRoutes.customerBookingDetailsScreen);
                  },
                  rating: rating,
                  name: 'David Bryan',
                  money: '10',
                  image: '',
                );
              },
            ),

            /// Next Pay Tab
            ListView.builder(
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
                  onTap: () {},
                  title: r'Price: $108',
                  name: 'David Bryan',
                  certificates: const ["ASE", "OEM"],
                  rating: rating,
                  status: 'On-going',
                  image: '',
                );
              },
            ),

            // History Tab
            ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.all(8.r),
              itemBuilder: (context, index) {
                return  BookingCardCustomer(
                  onTapDetails: (){
                    context.pushNamed(AppRoutes.towTruckDetailsScreen);
                  },
                  historyButtonAction: (){
                  },
                  isHistory: true,
                  name: 'David Bryan',
                  // title: 'New York, USA',
                  status: 'Complete',
                  rating: rating,
                  certificates: const ["ASE", "OEM"],
                  image: '',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
