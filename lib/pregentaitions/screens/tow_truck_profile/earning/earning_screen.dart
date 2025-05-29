import 'package:autorevive/controllers/payment_controller.dart';
import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/custom_loader.dart';
import '../../../widgets/earning_history_card.dart';
import '../../../widgets/no_data_found_card.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  PaymentController paymentController = Get.put(PaymentController());


  @override
  void initState() {
   paymentController.getPaymentHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: CustomText(
          color: AppColors.primaryColor,
          text: "Earnings",
          fontsize: 16.sp,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          /// ++++++++++++++++ balance ==================>
          Stack(
            alignment: Alignment.center,
            children: [
              Assets.images.balanceBg.image(height: 220.h, width: double.infinity, fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44.w),
                child: Column(
                  children: [

                    CustomText(
                      text: 'Your balance',
                      color: Colors.white,
                      fontsize: 20.sp,
                      top: 20,
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      text: '\$240',
                      color: Colors.white,
                      fontsize: 32.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 10.h),
                    CustomContainer(
                      paddingAll: 8.h,
                      radiusAll: 100.r,
                      color: AppColors.bgColorWhite,
                      width: double.infinity,
                      onTap: () {
                        context.pushNamed(AppRoutes.withdrawScreen);
                      },
                      child: CustomText(
                        text: 'Withdraw Now',
                        color: AppColors.primaryColor,
                      ),
                    ),



                    SizedBox(height: 10.h),
                    CustomContainer(
                      paddingAll: 8.h,
                      radiusAll: 100.r,
                      color: AppColors.bgColorWhite,
                      width: double.infinity,
                      onTap: () {
                        context.pushNamed(AppRoutes.addBalanceScreen);
                      },
                      child: CustomText(
                        text: 'Add Balance',
                        color: AppColors.primaryColor,
                      ),
                    ),


                    SizedBox(height: 30.h)



                  ],
                ),
              ),
            ],
          ),

          /// ====================== Earnings History ======================
          CustomText(
            top: 10.h,
            bottom: 10.h,
            textAlign: TextAlign.start,
            text: 'Earnings History',
            fontsize: 24.sp,
          ),
          Obx(()=>
          paymentController.paymentHistoryLoading.value ?  const CustomLoader() : paymentController.paymentHistory.isEmpty ?  const Center(child: NoDataFoundCard()) :
              Expanded(
                child: ListView.builder(
                    itemCount: paymentController.paymentHistory.length,
                    itemBuilder: (context, index) {
                      var history = paymentController.paymentHistory[index];

                      return EarningHistoryCard(
                        userName: 'Jeorge Mayank',
                      transactionId: '374364736',
                        date: history.createdAt != null
                            ? DateTime.parse('${history.createdAt!}')
                            .toIso8601String()
                            .split('T')
                            .first
                            : 'N/A',
                        amount: '${history.amount ?? 'N/A'}',
                     image: '',

                      );
                    }),
              ),)
        ],
      ),
    );
  }

}
