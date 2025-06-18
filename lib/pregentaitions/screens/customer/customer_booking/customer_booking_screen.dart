import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_listview_shimmer.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/no_data_found_card.dart';
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

class _CustomerBookingScreenState extends State<CustomerBookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  CustomerBookingController bookingController = Get.find<CustomerBookingController>();


  @override
  void initState() {

    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      print("**************************************** called **********************************");

      if (_tabController.indexIsChanging) return;

      final index = _tabController.index;
      bookingController.booking.clear();
      if (index == 0) {
        bookingController.fetchBooking(status: "requested", nextStatus: "accepted");
      } else if (index == 1) {
        bookingController.fetchBooking(status: "serviced", nextStatus: "paid");
      } else {
        bookingController.fetchBooking(status: "history");
      }
    });

    // Initial fetch
    bookingController.booking.clear();
    bookingController.fetchBooking(status: "requested", nextStatus: "accepted");

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
            controller: _tabController,
            enableFeedback: true,
            onTap: (value) {
              print("-------------------------------status = $value");

              if(value == 0){
                bookingController.booking.clear();
                bookingController.fetchBooking(status: "requested", nextStatus: "accepted");
              }else if(value == 1){
                bookingController.booking.clear();
                bookingController.fetchBooking(status: "serviced", nextStatus: "paid");
              }else{
                bookingController.booking.clear();
                bookingController.fetchBooking(status: "history");
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
        body: Padding(
          padding:  EdgeInsets.only(bottom: 100.h),
          child: TabBarView(
            controller: _tabController,
            children: [
              /// ===================================> Requested Tab ===============================>
              Obx(() =>
              bookingController.bookingLoading.value ? const CustomListviewShimmer()  : bookingController.booking.isEmpty ? const NoDataFoundCard() :
                 ListView.builder(
                  itemCount: bookingController.booking.length,
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  itemBuilder: (context, index) {
                    var booking = bookingController.booking[index];

                    print("========================'${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}'");
                    return BookingCardCustomer(
                      btnVisible:  booking.status == "accepted"  ? false : true,
                      acceptCancelBtnName: [booking.platform == "in shop" && booking.status == "accepted" ? "Pay now" : "Accept", "Cancel"],
                      buttonLabel: 'Cancel',
                      onTapDetails: () {
                        // context.pushNamed(AppRoutes.towTruckDetailsScreen);
                      },
                      certificates: booking.providerId?.certifications ?? [],
                      address: booking.platform?.toLowerCase() == "on site" ? "" : booking.platform?.toLowerCase() == "in shop" ? "${booking.providerId?.address}" : 'Distance : ${"${booking.providerId?.distance?.toStringAsFixed(2)}"}',
                      onTap: (){
                        context.pushNamed(AppRoutes.customerBookingDetailsScreen, extra: {
                          "title" : "Complete",
                          "name" : booking.providerId?.name  ??"",
                          "address" : booking.providerId?.address ?? "",
                          "rating" : booking.providerId?.avgRating ?? 0,
                          "certifications" :  booking.providerId?.certifications ?? [],
                          "image" : "${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}",
                          "price" : booking.transportPrice ?? 0,
                          "id" : "${booking.id}",
                          "btnVisible" : booking.status == "accepted"  ? false : true,
                        }).then((_){
                          bookingController.booking.clear();
                          bookingController.fetchBooking(status: "requested", nextStatus: "accepted");
                        });
                      },
                      rating: (booking.providerId?.avgRating ?? 0).toInt(),
                      name: booking.providerId?.name.toString() ?? "",
                      money: booking.providerId?.role == "tow_truck" ? "${booking.servicePrice?.toStringAsFixed(2)}" : booking.transportPrice?.toString() ?? "",
                      image: booking.providerId?.profileImage != null ? '${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}' : "",
                      id: booking.id.toString(),

                    );
                  },
                ),
              ),

              /// Next Pay Tab
              Obx(() =>
              bookingController.bookingLoading.value ? CustomListviewShimmer(): bookingController.booking.isEmpty ? const NoDataFoundCard() :
                 ListView.builder(
                  itemCount: bookingController.booking.length,
                  padding: EdgeInsets.all(8.r),
                  itemBuilder: (context, index) {
                    var booking = bookingController.booking[index];
                    return BookingCardCustomer(
                      isNextPaySection: true,
                      acceptCancelBtnName: [booking.status == "paid" ? "Complete" : "Pay Now", "Cancel"],
                      isNextPay:  booking.platform?.toLowerCase() == "in shop" ? false : true,
                      title: 'Price: \$${booking.servicePrice?.toStringAsFixed(2) ?? "0"}',
                      name: '${booking.providerId?.name ?? "N/A"}',
                      certificates: booking.providerId?.certifications ?? [],
                      rating: (booking.providerId?.avgRating ?? 0).toInt(),
                      status: 'On-going',
                      image: '${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}',
                      id: booking.id.toString(),
                      buttonLabel: booking.status == "serviced" ? 'Pay Now' : "See Details",
                      address:  booking.platform?.toLowerCase() == "on site" ? "" :  booking.platform?.toLowerCase() == "in shop" ? "${booking.providerId?.address}" : 'Distance : ${(booking.providerId?.distance)?.toStringAsFixed(2)}',

                      onTapDetails: () {
                        context.pushNamed(AppRoutes.towTruckDetailsScreen);
                      },

                      ///===================>>> See Details Or Pay Now BTN ==============>>>>

                      nextPayCardBtnOnTap: ()async {

                        // if(booking.status == "serviced"){
                        //   // var response = await bookingController.customerInitBooking(
                        //   //     status: "accepted",
                        //   //     id: booking.id.toString(),
                        //   //     isToast: false);
                        //   //
                        //   // if (response == "completed") {
                        //   //   VibrationService.vibrateForDuration(2500);
                        //   //   QuickAlertHelper.showSuccessAlert(
                        //   //       context, "Your initial payment has been successfully processed.");
                        //   // } else if (response == "fail") {
                        //   //   VibrationService.vibrateForDuration(2500);
                        //   //   QuickAlertHelper.showErrorAlert(context,
                        //   //       "Sorry, something went wrong Please Try Again");
                        //   // }
                        // }else{
                          context.pushNamed(AppRoutes.customerBookingDetailsScreen, extra: {
                            "title" : "Details",
                            "name" : booking.providerId?.name??"",
                            "address" : booking.providerId?.address ?? "",
                            "rating" : booking.providerId?.avgRating ?? 0,
                            "certifications" :  booking.providerId?.certifications ?? [],
                            "image" : "${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}",
                            "price" : booking.servicePrice ?? 0,
                            "id" : "${booking.id}",
                            "provideId" : "${booking.providerId?.id}",
                            "status" : "${booking.status}",
                            "lat" : booking.providerId?.location?[1],
                            "log" : booking.providerId?.location?[0],
                          }).then((_){
                            bookingController.booking.clear();
                            bookingController.fetchBooking(status: "serviced", nextStatus: "paid");
                          });
                        // }
                      },


                      ///===================>>> Whole Card On Tap ==============>>>>

                      onTap: () {
                        context.pushNamed(AppRoutes.customerBookingDetailsScreen, extra: {
                        "title" : "Details",
                        "name" : booking.providerId?.name??"",
                        "address" : booking.providerId?.address ?? "",
                        "rating" : booking.providerId?.avgRating ?? 0,
                        "certifications" :  booking.providerId?.certifications ?? [],
                        "image" : "${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}",
                        "price" : booking.servicePrice ?? 0,
                          "provideId" : "${booking.providerId?.id}",
                        "id" : "${booking.id}",
                          "status" : "${booking.status}",
                          "lat" : booking.providerId?.location?[1],
                          "log" : booking.providerId?.location?[0],
                        }).then((_){
                          bookingController.booking.clear();
                          bookingController.fetchBooking(status: "serviced", nextStatus: "paid");
                        });
                      },

                      buttonColor: AppColors.primaryShade300,
                    );
                  },
                ),
              ),

              /// =====================================> History Tab ============================================>
              Obx(() =>
              bookingController.bookingLoading.value ? const CustomListviewShimmer(): bookingController.booking.isEmpty ? const NoDataFoundCard() :
                 ListView.builder(
                  itemCount: bookingController.booking.length,
                  padding: EdgeInsets.all(8.r),
                  itemBuilder: (context, index) {
                    var booking = bookingController.booking[index];
                    return  BookingCardCustomer(
                      onTapDetails: (){
                        // context.pushNamed(AppRoutes.towTruckDetailsScreen);
                      },
                      historyButtonAction: (){
                      },
                      isHistory: true,
                      name: '${booking.providerId?.name ?? "N/A"}',
                      // title: 'New York, USA',
                      status:  booking.status, //'Complete',
                      rating: (booking.providerId?.avgRating ?? 0).toInt(),
                    certificates:  booking.providerId?.certifications ?? [],
                      image: '${ApiConstants.imageBaseUrl}/${booking.providerId?.profileImage}',
                      id: booking.id.toString(),
                    );
                  },
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
