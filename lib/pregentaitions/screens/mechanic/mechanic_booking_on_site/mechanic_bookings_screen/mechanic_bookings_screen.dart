import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/booking_card_widget.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../controllers/mechanic_controller/mechanic_on_site_controller/booking_all_filters_controller.dart';
import '../../../../../services/api_constants.dart';
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/no_data_found_card.dart';

class MechanicBookingsScreen extends StatefulWidget {
  const MechanicBookingsScreen({super.key});

  @override
  State<MechanicBookingsScreen> createState() =>
      _MechanicBookingsScreenState();
}

class _MechanicBookingsScreenState extends State<MechanicBookingsScreen>  with SingleTickerProviderStateMixin{
  late TabController _tabController;


  MechanicBookingAllFiltersController mechanicBookingAllFiltersController = Get.put(MechanicBookingAllFiltersController());
  bool isLoading = true;

  @override
  void initState() {

    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      mechanicBookingAllFiltersController.bookingFilters.clear();
      if (_tabController.index == 0) {
        mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'requested');
      } else if (_tabController.index == 1) {
        mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'accepted');
      } else {
        mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'history');
      }
    });
    mechanicBookingAllFiltersController.bookingFilters.clear();
    mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'requested');
    super.initState();


    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            onTap: (value) {
              print("-------------------------------status = $value");
              if (value == 0) {
                mechanicBookingAllFiltersController.bookingFilters.clear();
                mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'requested');
              } else if (value == 1) {
                mechanicBookingAllFiltersController.bookingFilters.clear();
                mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'accepted');
              } else {
                mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'history');
              }
            },
            tabs: const [
              Tab(text: 'Requested'),
              Tab(text: 'Accepted'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body:isLoading
            ? SingleChildScrollView(child: _buildShimmerBookings())
            :
           Padding(
             padding:  EdgeInsets.only(bottom: 100.h),

             child: TabBarView(
               controller: _tabController,
              children: [
                /// =================================> Requested Tab ===================================>
                Obx(()=>
                mechanicBookingAllFiltersController.loading.value ?  const CustomLoader() : mechanicBookingAllFiltersController.bookingFilters.isEmpty ?  const Center(child: NoDataFoundCard()) :
                   ListView.builder(
                   itemCount: mechanicBookingAllFiltersController.bookingFilters.length,
                   padding: EdgeInsets.all(16.r),
                   itemBuilder: (context, index) {
                     var bookingAllFilters = mechanicBookingAllFiltersController.bookingFilters[index];
                     return BookingCardWidget(

                       locationOnTap:  () {
              context.pushNamed(AppRoutes.mechanicMapScreen, extra: {
                "name" : bookingAllFilters.customerId!.name,
                "address" :  bookingAllFilters.customerId!.address,
                "rating" : '0.0',
                "lat" :  bookingAllFilters.customerId?.location?[1],
                "log" : bookingAllFilters.customerId?.location?[0],
                "image" :  bookingAllFilters.customerId!.profileImage,
              });
                       },


                       isAccepted: true,
                       buttonLabel: 'Cancel',
                       onTapDetails: () {
              // context.pushNamed(
              //     AppRoutes.mechanicBookingsDetailsScreen,
              //   extra: {
              //     "title" : "Details",
              //     "name" :  bookingAllFilters.customerId?.name??"",
              //     "address" :  bookingAllFilters.customerId?.address ?? "",
              //     "image": bookingAllFilters.customerId?.profileImage != null ? "${ApiConstants.imageBaseUrl}/${bookingAllFilters.customerId?.profileImage}": "",
              //   }
              // );
                       },
                       onTap: (){
              mechanicBookingAllFiltersController.changeStatus(
                  status: bookingAllFilters.status,
                  jobId: bookingAllFilters.id,
                  context: context);
                       },
                       name: bookingAllFilters.customerId?.name ?? 'N/A',
                       address: bookingAllFilters.customerId?.address ?? 'N/A',
                       subTitle: bookingAllFilters.carModel ?? 'N/A',
                       image: bookingAllFilters.customerId?.profileImage != null ? "${ApiConstants.imageBaseUrl}/${bookingAllFilters.customerId?.profileImage}": "",
                     );
                   },
                 )

                ),
                /// ===============================> Accepted Tab =======================================>

                Obx(()=>
                mechanicBookingAllFiltersController.loading.value ?  const CustomLoader() : mechanicBookingAllFiltersController.bookingFilters.isEmpty ?  const Center(child: NoDataFoundCard()) :

                    ListView.builder(
                      itemCount: mechanicBookingAllFiltersController.bookingFilters.length,
                      padding: EdgeInsets.all(8.r),
                      itemBuilder: (context, index) {
                        var bookingAllFilters = mechanicBookingAllFiltersController.bookingFilters[index];
                        return BookingCardWidget(
                          locationOnTap:  () {
                            context.pushNamed(AppRoutes.mechanicMapScreen, extra: {
                              "name" : bookingAllFilters.customerId!.name,
                              "address" :  bookingAllFilters.customerId!.address,
                              "rating" : '0.0',
                              "lat" :  bookingAllFilters.customerId?.location?[1],
                              "log" : bookingAllFilters.customerId?.location?[0],
                              "image" :  bookingAllFilters.customerId!.profileImage,
                            });
                          },
                          isAccepted: true,
                          buttonLabel: 'Confirm',
                          buttonColor: AppColors.primaryShade300,
                          onTapDetails: () {

                          },
                          onTap: () {
                            context.pushNamed(AppRoutes.mechanicBookingsDetailsScreen,
                                extra: {
                                  "title" : "Details",
                                  "name" :  bookingAllFilters.customerId?.name??"",
                                  "address" :  bookingAllFilters.customerId?.address ?? "",
                                  "image": bookingAllFilters.customerId?.profileImage != null ? "${ApiConstants.imageBaseUrl}/${bookingAllFilters.customerId?.profileImage}": "",
                                  "id": bookingAllFilters.id
                                }
                            );

                          },
                          name: bookingAllFilters.customerId?.name ?? 'N/A',
                          address: bookingAllFilters.customerId?.address ?? 'N/A',
                          subTitle: bookingAllFilters.carModel ?? 'N/A',
                          image: bookingAllFilters.customerId?.profileImage != null ? "${ApiConstants.imageBaseUrl}/${bookingAllFilters.customerId?.profileImage}": "",
                        );
                      },
                    )
                ),

                /// ==================================> History Tab =====================================>

                Obx(()=>
                mechanicBookingAllFiltersController.loading.value ?  const CustomLoader() : mechanicBookingAllFiltersController.bookingFilters.isEmpty ?  const Center(child: NoDataFoundCard()) :
                    ListView.builder(
                      itemCount: mechanicBookingAllFiltersController.bookingFilters.length,
                      padding: EdgeInsets.all(8.r),
                      itemBuilder: (context, index) {
                        var bookingAllFilters = mechanicBookingAllFiltersController.bookingFilters[index];
                        return  BookingCardWidget(
                          locationOnTap:  () {
                            context.pushNamed(AppRoutes.mechanicMapScreen, extra: {
                              "name" : bookingAllFilters.customerId!.name,
                              "address" :  bookingAllFilters.customerId!.address,
                              "rating" : '0.0',
                              "lat" :  bookingAllFilters.customerId?.location?[1],
                              "log" : bookingAllFilters.customerId?.location?[0],
                              "image" :  bookingAllFilters.customerId!.profileImage,
                            });
                          },
                          onTapDetails: (){
                            // context.pushNamed(AppRoutes.mechanicBookingsDetailsScreen,);
                          },
                          historyButtonAction: (){

                          },
                          isHistory: true,
                          name: bookingAllFilters.customerId?.name ?? 'N/A',
                          address: bookingAllFilters.customerId?.address ?? 'N/A',
                          subTitle: bookingAllFilters.carModel ?? 'N/A',
                          status: bookingAllFilters.status ?? 'N/A',
                          image: bookingAllFilters.customerId?.profileImage != null ? "${ApiConstants.imageBaseUrl}/${bookingAllFilters.customerId?.profileImage}": "",
                        );
                      },
                    )

                ),
              ],
                       ),
           ),
      ),
    );
  }

  Widget _buildShimmerBookings() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight + 16.h), // space for AppBar

            // Linear progress indicator placeholder
            Container(
              height: 8.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 20.h),

            // Generate multiple booking card placeholders
            ...List.generate(4, (_) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 13,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: status & location icon placeholders
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80.w,
                          height: 12.h,
                          color: Colors.grey.shade400,
                        ),
                        Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // Avatar & details row
                    Row(
                      children: [
                        // Avatar circle placeholder
                        Container(
                          width: 64.r,
                          height: 64.r,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name placeholder
                              Container(
                                width: 150.w,
                                height: 20.h,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(height: 8.h),

                              // Address placeholder
                              Container(
                                width: 200.w,
                                height: 14.h,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(height: 8.h),

                              // Subtitle placeholder (car model)
                              Container(
                                width: 120.w,
                                height: 14.h,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Action button placeholder
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(height: 70.h),
          ],
        ),
      ),
    );
  }



}
