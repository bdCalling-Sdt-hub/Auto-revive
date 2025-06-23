import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:go_router/go_router.dart';

import '../../../../controllers/payment_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../helpers/toast_message_helper.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {


  final TextEditingController _amountController = TextEditingController();
  PaymentController paymentController = PaymentController();


  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;

    return CustomScaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Withdraw",
          color: AppColors.primaryColor,
          fontsize: 16.sp,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  Assets.images.balanceBg
                      .image(height: 180.h, width: double.infinity),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 44.w),
                    child: Column(
                      children: [
                        CustomText(
                          text: 'Your balance',
                          color: Colors.white,
                          fontsize: 20.sp,
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: "\$${double.parse(extra.toString()).toStringAsFixed(2) ?? 'N/A'}",
                          color: Colors.white,
                          fontsize: 32.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),

              /// Withdraw Button
              CustomButton(
                title: 'Withdraw Request',
                onpress: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 20.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Icon(Icons.close, size: 24.sp),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Amount',
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: _amountController,
                                    hintText: "Enter amount",
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'Please enter an amount';
                                      }
                                      final amount = double.tryParse(value);
                                      if (amount == null || amount <= 0) {
                                        return 'Enter a valid amount';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Divider(
                              height: 8.h,
                              thickness: 0.8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Withdraw amount',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                CustomText(
                                  maxline: 2,
                                  text:
                                  '\$${double.parse(extra.toString()).toStringAsFixed(2) ?? 'N/A'}',
                                  color: AppColors.primaryColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),

                            Obx(() =>
                               CustomButton(
                                loading: paymentController.withDrawLoading.value,
                                  title: "Withdraw",
                                 onpress: () {

                                   if (_amountController.text.trim().isEmpty) {
                                     ToastMessageHelper.showToastMessage('Please enter an amount!', title: 'Attention');
                                     return;
                                   }
                                   // Navigator.of(context).pop();
                                   if(_amountController.text != ""){
                                     paymentController.withdrawRequestBalance(
                                         context: context,
                                         price: _amountController.text
                                     );
                                   }else{
                                     ToastMessageHelper.showToastMessage("Enter balance !");
                                   }

                                 },

                              ),
                            ),



                            // SizedBox(
                            //   width: double.infinity,
                            //   child: ElevatedButton(
                            //     onPressed: () {
                            //
                            //       if (_amountController.text.trim().isEmpty) {
                            //         ToastMessageHelper.showToastMessage('Please enter an amount!', title: 'Attention');
                            //         return;
                            //       }
                            //       // Navigator.of(context).pop();
                            //       if(_amountController.text != ""){
                            //         paymentController.withdrawRequestBalance(
                            //             context: context,
                            //             price: _amountController.text
                            //         );
                            //       }else{
                            //         ToastMessageHelper.showToastMessage("Enter balance !");
                            //       }
                            //
                            //     },
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor: AppColors.primaryColor,
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(30.r),
                            //       ),
                            //       padding:
                            //       EdgeInsets.symmetric(vertical: 14.h),
                            //     ),
                            //     child: CustomText(
                            //       text: 'Ok',
                            //       color: AppColors.bgColorWhiteFFFFFF,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
