import 'package:autorevive/helpers/toast_message_helper.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/payment_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../widgets/custom_text_field.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({super.key});

  @override
  State<AddBalanceScreen> createState() => _AddBalanceScreenState();
}

class _AddBalanceScreenState extends State<AddBalanceScreen> {
  final TextEditingController _amountController = TextEditingController();
  PaymentController paymentController = PaymentController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Add Balance",
          color: AppColors.primaryColor,
          fontsize: 16.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              maxline: 10,
              text:
              "You need to add balance to your wallet in order to pay for services within the app.",
              fontsize: 14.sp,
              color: Colors.black87,
              textAlign: TextAlign.start,
              bottom: 20.h,
            ),



            CustomTextField(
                controller: _amountController,
                hintText: "Enter Amount",
              labelText: "Enter a amount",
              keyboardType: TextInputType.number,
                ),


            const Spacer(),
            CustomContainer(
              width: double.infinity,
              radiusAll: 12.r,
              verticalPadding: 12.h,
              color: AppColors.primaryColor,
              onTap: (){

                if(_amountController.text != ""){
                  paymentController.requestToAddBalance(
                    context: context,
                    price: _amountController.text
                  );
                }else{
                  ToastMessageHelper.showToastMessage("Enter balance !");
                }


              },
              child: Center(
                child: CustomText(
                  text: "Add Balance Now",
                  color: Colors.white,
                  fontsize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 100.h)
          ],
        ),
      ),
    );
  }
}
