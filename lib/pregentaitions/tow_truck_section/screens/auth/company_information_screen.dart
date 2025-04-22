import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_phone_number_picker.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CompanyInformationScreen extends StatefulWidget {
  const CompanyInformationScreen({super.key});

  @override
  State<CompanyInformationScreen> createState() =>
      _CompanyInformationScreenState();
}

class _CompanyInformationScreenState extends State<CompanyInformationScreen> {
  final TextEditingController _companyNameTEController = TextEditingController();
  final TextEditingController _ownerNameTEController = TextEditingController();
  final TextEditingController _businessPhoneTEController = TextEditingController();
  final TextEditingController _businessEmailTEController = TextEditingController();
  final TextEditingController _companyAddressTEController = TextEditingController();
  final TextEditingController _websiteURLTEController = TextEditingController();
  final TextEditingController _businessYearTEController = TextEditingController();
  final TextEditingController _towTrucksTEController = TextEditingController();
  final TextEditingController _eINTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          centerTitle: false,
          title: CustomText(
            text: "Company Information",
            fontsize: 20.sp,
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomLinearIndicator(
                progressValue: 0.1,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _companyNameTEController,
                labelText: 'Company Name',
                hintText: 'Enter Company name',
              ),


              CustomTextField(
                controller: _ownerNameTEController,
                labelText: 'Owner / Manager Name',
                hintText: 'Owner / Manager Name',
              ),


              /// ++++++++++++++++++++++  phone number  ==================>
              CustomPhoneNumberPicker(
                lebelText : 'Business Phone No.',
                controller: _businessPhoneTEController,),


              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                controller: _businessEmailTEController,
                labelText: 'Business Email Address',
                hintText: 'Business Email Address',
              ),


              CustomTextField(
                controller: _companyAddressTEController,
                labelText: 'Company Address',
                hintText: 'Company Address',
              ),


              CustomTextField(
                controller: _websiteURLTEController,
                labelText: 'Website URL',
                hintText: 'David William LLC',
              ),


              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _businessYearTEController,
                labelText: 'Years in Businees',
                hintText: 'Years in Businees',
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: _towTrucksTEController,
                      labelText: 'Number of Tow Trucks in Fleet',
                      hintText: 'Number of Tow Trucks in Fleet',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  SizedBox(
                    width: 134.w,
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: _eINTEController,
                      labelText: 'Enter EIN number',
                      hintText: 'Enter EIN number',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 44.h),
              Center(
                  child: CustomButton(
                      title: 'Save and Next',
                      onpress: () {
                        if(_globalKey.currentState!.validate()) return;
                        context.pushNamed(AppRoutes.licensingAndComplianceScreen);
                      })),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
