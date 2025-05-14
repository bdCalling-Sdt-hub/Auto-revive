import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/booking_card_widget.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TowTrucksBookingsScreen extends StatefulWidget {
  const TowTrucksBookingsScreen({super.key});

  @override
  State<TowTrucksBookingsScreen> createState() =>
      _TowTrucksBookingsScreenState();
}

class _TowTrucksBookingsScreenState extends State<TowTrucksBookingsScreen> {
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
              Tab(text: 'Accepted'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            /// Requested Tab
            ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.all(16.r),
              itemBuilder: (context, index) {
                return BookingCardWidget(
                  buttonLabel: 'Cancel',
                  onTapDetails: () {
                    context.pushNamed(AppRoutes.towTruckDetailsScreen);

                  },
                  onTap: (){},
                  rating: rating,
                  address: '',
                  name: 'David Bryan',
                  subTitle: 'Sedan',
                  image: '',
                );
              },
            ),

            /// Accepted Tab
            ListView.builder(
              itemCount: 5,
              padding: EdgeInsets.all(8.r),
              itemBuilder: (context, index) {
                return BookingCardWidget(
                  isAccepted: true,
                  buttonLabel: 'Confirm',
                  buttonColor: AppColors.primaryShade300,
                  onTapDetails: () {
                    context.pushNamed(AppRoutes.towTruckDetailsScreen);
                  },
                  onTap: () {},
                  title: 'New York, USA',
                  name: 'David Bryan',
                  address: '',
                  subTitle: 'Sedan',
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
                return  BookingCardWidget(
                  onTapDetails: (){
                    context.pushNamed(AppRoutes.towTruckDetailsScreen);
                  },
                  historyButtonAction: (){
                  },
                  isHistory: true,
                  name: 'David Bryan',
                  address: '',
                  subTitle: 'Sedan',
                  title: 'New York, USA',
                  status: 'Complete',
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
