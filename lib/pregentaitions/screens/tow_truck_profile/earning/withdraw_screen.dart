import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
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
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
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
                          text: '\$240',
                          color: Colors.white,
                          fontsize: 32.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),




              SizedBox(height: 32.h),

              CustomTextField(
                labelText: 'Bank Name',
                  hintText: 'Bank Name',
                  controller: _bankNameController),


              CustomTextField(
                suffixIcon: Assets.images.balanceCardIcon.image(),
                labelText: 'Account Number',
                  hintText: 'Account Number',
                  controller: _accountNumberController),



              Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      labelText: 'Account Type',
                      hintText: 'Account Type',
                        controller: _accountTypeController),
                  ),
                  SizedBox(width: 24.w,),
                  Flexible(
                    child: CustomTextField(
                      labelText: 'Amount',
                      hintText: 'Amount',
                        controller: _accountController),
                  ),
                ],
              ),

              SizedBox(height: 100.h),
              CustomButton(title: 'Withdraw Request', onpress: (){}),

            ],
          ),
        ),
      ),
    );
  }
}
