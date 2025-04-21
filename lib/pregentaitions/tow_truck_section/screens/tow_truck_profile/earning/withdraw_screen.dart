import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {

  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: CustomText(
          color: AppColors.primaryColor,
          text: "Withdraw",
          fontsize: 16.sp,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          CustomContainer(
            width: double.infinity,
            paddingAll: 24.r,
            radiusAll: 16.r,
            color: AppColors.primaryShade300,
            child: Column(
              children: [
                CustomText(
                  text: 'Your balance',
                  color: Colors.white,
                  fontsize: 20.sp,
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text: '\$240',
                  color: Colors.white,
                  fontsize: 32.sp,
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
          CustomTextField(
            labelText: 'Bank Name',
              hintText: 'Bank Name',
              controller: _bankNameController),
          CustomTextField(
            labelText: 'Account Number',
              hintText: 'Account Number',
              controller: _accountNumberController),
          Row(
            children: [
              CustomTextField(
                labelText: 'Account Type',
                hintText: 'Account Type',
                  controller: _accountNumberController),
              CustomTextField(
                labelText: 'Amount',
                hintText: 'Amount',
                  controller: _accountNumberController),
            ],
          ),
          CustomButton(title: 'Withdraw Request', onpress: (){}),

        ],
      ),
    );
  }
}
