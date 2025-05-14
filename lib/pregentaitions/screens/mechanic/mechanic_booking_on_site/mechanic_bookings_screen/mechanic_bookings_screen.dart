import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/booking_card_widget.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../controllers/mechanic_controller/mechanic_on_site_controller/booking_all_filters_controller.dart';
import '../../../../../services/api_constants.dart';
import '../../../../widgets/custom_loader.dart';

class MechanicBookingsScreen extends StatefulWidget {
  const MechanicBookingsScreen({super.key});

  @override
  State<MechanicBookingsScreen> createState() =>
      _MechanicBookingsScreenState();
}

class _MechanicBookingsScreenState extends State<MechanicBookingsScreen> {


  MechanicBookingAllFiltersController mechanicBookingAllFiltersController = Get.put(MechanicBookingAllFiltersController());


  @override
  void initState() {
    super.initState();
    mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'requested');
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
            onTap: (value) {
              if (value == 0) {
                mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'requested');
              } else if (value == 1) {
                mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'accepted');
              } else {
                mechanicBookingAllFiltersController.mechanicBookingAllFilters(status: 'confirmed');
              }
            },
            tabs: const [
              Tab(
                text: 'Requested',
              ),
              Tab(text: 'Accepted'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body:
           TabBarView(
            children: [
              /// =================================> Requested Tab ===================================>
              Obx((){
                if (mechanicBookingAllFiltersController.loading.value) {
                  return  const Center(child: CustomLoader());
                }

                if (mechanicBookingAllFiltersController.bookingFilters.isEmpty) {
                  return const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
               return ListView.builder(
                  itemCount: mechanicBookingAllFiltersController.bookingFilters.length,
                  padding: EdgeInsets.all(16.r),
                  itemBuilder: (context, index) {
                    var bookingAllFilters = mechanicBookingAllFiltersController.bookingFilters[index];
                    return BookingCardWidget(
                      isAccepted: true,
                      buttonLabel: 'Cancel',
                      onTapDetails: () {
                        context.pushNamed(
                            AppRoutes.mechanicBookingsDetailsScreen,
                          extra: {
                            "title" : "Details",
                            "name" :  bookingAllFilters.customerId?.name??"",
                            "address" :  bookingAllFilters.customerId?.address ?? "",
                            "image": bookingAllFilters.customerId?.profileImage != null ? "${ApiConstants.imageBaseUrl}/${bookingAllFilters.customerId?.profileImage}": "",



                          }
                        );
                      },
                      onTap: (){
                        mechanicBookingAllFiltersController.changeStatus(
                          status: bookingAllFilters.status,
                            jobId: bookingAllFilters.id,
                            context: context);

                      },
                      name: bookingAllFilters.customerId?.name ?? 'N/A',
                      address: bookingAllFilters.customerId?.address ?? 'N/A',
                      subTitle: bookingAllFilters.jobId?.carModelId?.name ?? 'N/A',
                      image: bookingAllFilters.customerId?.profileImage != null ? "${ApiConstants.imageBaseUrl}/${bookingAllFilters.customerId?.profileImage}": "",
                    );
                  },
                );
              }

              ),

              /// ===============================> Accepted Tab =======================================>

              Obx((){
                if (mechanicBookingAllFiltersController.loading.value) {
                  return  const Center(child: CustomLoader());
                }

                if (mechanicBookingAllFiltersController.bookingFilters.isEmpty) {
                  return const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: mechanicBookingAllFiltersController.bookingFilters.length,
                  padding: EdgeInsets.all(8.r),
                  itemBuilder: (context, index) {
                    var bookingAllFilters = mechanicBookingAllFiltersController.bookingFilters[index];
                    return BookingCardWidget(
                      isAccepted: true,
                      buttonLabel: 'Confirm',
                      buttonColor: AppColors.primaryShade300,
                      onTapDetails: () {
                        context.pushNamed(AppRoutes.mechanicBookingsDetailsScreen);
                      },
                      onTap: () {
                        mechanicBookingAllFiltersController.changeStatus(
                            status: bookingAllFilters.status,
                            jobId: bookingAllFilters.id,
                            context: context);

                      },
                      name: bookingAllFilters.customerId?.name ?? 'N/A',
                      address: bookingAllFilters.customerId?.address ?? 'N/A',
                      subTitle: bookingAllFilters.jobId?.carModelId?.name ?? 'N/A',
                      image: bookingAllFilters.customerId?.profileImage != null ? "${ApiConstants.imageBaseUrl}/${bookingAllFilters.customerId?.profileImage}": "",
                    );
                  },
                );
              }

              ),

              /// ==================================> History Tab =====================================>

              Obx(()=>
                 ListView.builder(
                   itemCount: mechanicBookingAllFiltersController.bookingFilters.length,
                  padding: EdgeInsets.all(8.r),
                  itemBuilder: (context, index) {
                    var bookingAllFilters = mechanicBookingAllFiltersController.bookingFilters[index];
                    return  BookingCardWidget(
                      onTapDetails: (){
                        context.pushNamed(AppRoutes.mechanicBookingsDetailsScreen);
                      },
                      historyButtonAction: (){},
                      isHistory: true,
                      name: bookingAllFilters.customerId?.name ?? 'N/A',
                      address: bookingAllFilters.customerId?.address ?? 'N/A',
                      subTitle: bookingAllFilters.carModel ?? 'N/A',
                      status: bookingAllFilters.status ?? 'N/A',
                      image: bookingAllFilters.customerId?.profileImage != null ? "${ApiConstants.imageBaseUrl}/${bookingAllFilters.customerId?.profileImage}": "",
                    );
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }
}
