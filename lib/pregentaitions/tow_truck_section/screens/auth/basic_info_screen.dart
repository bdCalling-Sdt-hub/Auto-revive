import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _lLCTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          centerTitle: false,
          title: CustomText(
            text: "Basic Info...",
            fontsize: 20.sp,
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomLinearIndicator(
              progressValue: 0.03,
              label: 0,
            ),
            SizedBox(height: 16.h),
            Center(
              child: CustomImageAvatar(
                radius: 60.r,
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: _nameTEController,
              labelText: 'Full Name',
              hintText: 'Enter your name',
            ),
            CustomTextField(
              controller: _addressTEController,
              labelText: 'Business Address',
              hintText: 'USA, New York',
            ),
            CustomTextField(
              controller: _emailTEController,
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
            CustomTextField(
              controller: _priceTEController,
              labelText: 'Price Per Mile',
              hintText: 'Enter your price',
            ),
            CustomText(text: 'Phone No.'),
            Row(
              children: [
                CountryPickerDropdown(
                  initialValue: 'US',
                  itemBuilder: _buildDropdownItem,
                  onValuePicked: (Country country) {
                    print("${country.name} +${country.phoneCode}");
                  },
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomTextField(
                    controller: _phoneTEController,
                    hintText: 'Enter your number',
                  ),
                ),
              ],
            ),
            CustomTextField(
              controller: _lLCTEController,
              labelText: 'Partner with LLC for Reliable Towing Service',
              hintText: 'David William LLC',
            ),
        
            SizedBox(height: 44.h),
            Center(child: CustomButton(title: 'Save and Next', onpress: (){
              context.pushNamed(AppRoutes.companyInformationScreen);
            })),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0.w),
          Text("+${country.phoneCode}"),
        ],
      );
}
