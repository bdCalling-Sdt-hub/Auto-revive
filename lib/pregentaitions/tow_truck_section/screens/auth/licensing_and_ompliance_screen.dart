import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/CustomChecked.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LicensingAndComplianceScreen extends StatefulWidget {
  const LicensingAndComplianceScreen({super.key});

  @override
  State<LicensingAndComplianceScreen> createState() =>
      _LicensingAndComplianceScreenState();
}

class _LicensingAndComplianceScreenState
    extends State<LicensingAndComplianceScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _lLCTEController = TextEditingController();

  bool? validUSDOTNumber;

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
              progressValue: 0.33,
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: 'Do you have a valid US-DOT number? *',
            ),
            CustomChecked(
              selected: validUSDOTNumber,
              onChanged: (val) {
                setState(() {
                  validUSDOTNumber = val;
                });
              },
            ),
            CustomTextField(
              controller: _nameTEController,
              labelText: 'US-DOT Number',
              hintText: 'US-DOT Number',
            ),
            CustomUploadButton(
              topLabel: 'Upload Proof of a Active DOT registration',
              title: 'DOT registration.pdf',
              icon: Icons.upload,
              onTap: () {},
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
            Center(
                child: CustomButton(
                    title: 'Save and Next',
                    onpress: () {
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
