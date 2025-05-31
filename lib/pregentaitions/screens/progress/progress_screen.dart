import 'package:autorevive/controllers/progress_controller.dart';
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
import '../../widgets/booking_card_customer.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  ProgressController progressController = Get.put(ProgressController());

  @override
  void initState() {
    progressController.fetchProgress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Obx(
                () => progressController.progressLoading.value
                    ? const CustomListviewShimmer()
                    : progressController.progress.isEmpty
                        ? NoDataFoundCard()
                        : ListView.builder(
                            itemCount: progressController.progress.length,
                            padding: EdgeInsets.all(8.r),
                            itemBuilder: (context, index) {
                              var progress = progressController.progress[index];
                              return BookingCardCustomer(
                                isHistory: true,
                                buttonLabel: 'Cancel',
                                // acceptCancelBtnName: const ["Complete", "Cancel"],
                                buttonColor: AppColors.primaryShade300,
                                onTapDetails: () {
                                  // context.pushNamed(
                                  //     AppRoutes.towTruckDetailsScreen);
                                },
                                onTap: () {
                                  // context.pushNamed(
                                  //     AppRoutes.customerBookingDetailsScreen,
                                  //     extra: {"title": "Details"});
                                },
                                name: '${progress.provider?.name ?? "N/A"}',
                                address: '${progress.provider?.address ?? "N/A"}',
                                rating: progress.provider?.avgRating,
                                status: '${progress.status}',
                                image: '${ApiConstants.imageBaseUrl}/${progress.provider?.profileImage}',
                              );
                            },
                          ),
              ),
            ),
            SizedBox(height: 45.h)
          ],
        ));
  }
}
