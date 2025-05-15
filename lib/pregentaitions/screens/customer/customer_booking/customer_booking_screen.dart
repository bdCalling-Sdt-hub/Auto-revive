import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/booking_card_widget.dart';
import 'package:autorevive/pregentaitions/widgets/custom_loader.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../controllers/customer/customer_booking_controller.dart';
import '../../../widgets/booking_card_customer.dart';

class CustomerBookingScreen extends StatefulWidget {
  const CustomerBookingScreen({super.key});

  @override
  State<CustomerBookingScreen> createState() => _CustomerBookingScreenState();
}

class _CustomerBookingScreenState extends State<CustomerBookingScreen> {


  CustomerBookingController bookingController = Get.find<CustomerBookingController>();

  @override
  void initState() {
    bookingController.booking.clear();
    bookingController.fetchBooking(status: "requested");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
            onTap: (value) {
              print("-------------------------------status = $value");

              if(value == 0){
                bookingController.booking.clear();
                bookingController.fetchBooking(status: "requested");
              }else if(value == 1){
                bookingController.booking.clear();
                bookingController.fetchBooking(status: "serviced");
              }else{
                bookingController.booking.clear();
                bookingController.fetchBooking(status: "requested");
              }
            },
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
            Obx(() =>
            bookingController.bookingLoading.value ? const CustomLoader() :
               ListView.builder(
                itemCount: bookingController.booking.length,
                padding: EdgeInsets.symmetric(vertical: 4.h),
                itemBuilder: (context, index) {
                  var booking = bookingController.booking[index];

                  print("========================'${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}'");
                  return BookingCardCustomer(
                    buttonLabel: 'Cancel',
                    onTapDetails: () {
                      context.pushNamed(AppRoutes.towTruckDetailsScreen);
                    },
                    certificates: booking.providerId?.certifications ?? [],
                    onTap: (){
                      context.pushNamed(AppRoutes.customerBookingDetailsScreen, extra: {
                        "title" : "Complete",
                        "name" : booking.providerId?.name??"",
                        "address" : booking.providerId?.address ?? "",
                        "rating" : booking.providerId?.avgRating ?? 0,
                        "certifications" :  booking.providerId?.certifications ?? [],
                        "image" : "${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}",
                        "price" : booking.transportPrice ?? 0,
                        "id" : "${booking.id}"
                      });
                    },
                    rating: booking.providerId?.avgRating ?? 0,
                    name: booking.providerId?.name.toString() ?? "",
                    money: booking.transportPrice?.toString() ?? "",
                    image: booking.providerId?.profileImage != null ? '${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}' : "",
                  );
                },
              ),
            ),

            /// Next Pay Tab
            Obx(() =>
            bookingController.bookingLoading.value ? const CustomLoader() :
               ListView.builder(
                itemCount: bookingController.booking.length,
                padding: EdgeInsets.all(8.r),
                itemBuilder: (context, index) {
                  var booking = bookingController.booking[index];
                  return BookingCardCustomer(
                    isNextPay: true,
                    buttonLabel: 'Pay Now',
                    buttonColor: AppColors.primaryShade300,
                    onTapDetails: () {
                      context.pushNamed(AppRoutes.towTruckDetailsScreen);
                    },
                    onTap: () {
                      context.pushNamed(AppRoutes.customerBookingDetailsScreen, extra: {
                      "title" : "Details",
                      "name" : booking.providerId?.name??"",
                      "address" : booking.providerId?.address ?? "",
                      "rating" : booking.providerId?.avgRating ?? 0,
                      "certifications" :  booking.providerId?.certifications ?? [],
                      "image" : "${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}",
                      "price" : booking.transportPrice ?? 0,
                      "id" : "${booking.id}"
                      });
                    },
                    title: 'Price: \$${booking.transportPrice ?? "0"}',
                    name: '${booking.providerId?.name ?? "N/A"}',
                    certificates: booking.providerId?.certifications ?? [],
                    rating: booking.providerId?.avgRating ?? 0,
                    status: 'On-going',
                    image: '${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}',
                  );
                },
              ),
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
                  rating: 0,
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
