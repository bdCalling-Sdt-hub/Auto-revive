import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/CustomChecked.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LicensingAndComplianceScreen extends StatefulWidget {
  const LicensingAndComplianceScreen({super.key});

  @override
  State<LicensingAndComplianceScreen> createState() =>
      _LicensingAndComplianceScreenState();
}

class _LicensingAndComplianceScreenState extends State<LicensingAndComplianceScreen> {
  final TextEditingController _uSDOTNumberTEController = TextEditingController();
  final TextEditingController _policyNumberTEController = TextEditingController();
  final TextEditingController _coverageLimitsTEController = TextEditingController();
  final TextEditingController _mCNumberTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  bool? validUSDOTNumber;
  bool? coverageNumber;
  bool? mCNumber;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          centerTitle: false,
          title: CustomText(
            text: "Licensing and Compliance",
            fontsize: 20.sp,
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomLinearIndicator(
                progressValue: 0.2,
              ),
              SizedBox(height: 16.h),


              CustomChecked(
                title: 'Do you have a valid US-DOT number? *',
                selected: validUSDOTNumber,
                onChanged: (val) {
                  setState(() {
                    validUSDOTNumber = val;
                  });
                },
              ),


              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _uSDOTNumberTEController,
                labelText: 'US-DOT Number',
                hintText: 'US-DOT Number',
              ),


              CustomUploadButton(
                topLabel: 'Do you have commercial insurance coverage?*',
                title: 'DOT registration.pdf',
                icon: Icons.upload,
                onTap: () {},
              ),


              CustomChecked(
                title: 'Do you have commercial insurance coverage?*',
                selected: coverageNumber,
                onChanged: (val) {
                  setState(() {
                    coverageNumber = val;
                  });
                },
              ),


              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _policyNumberTEController,
                labelText: 'Policy Number',
                hintText: 'Policy Number',
              ),


              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _coverageLimitsTEController,
                labelText: 'Coverage Limits',
                hintText: 'Coverage Limits',
              ),


              CustomUploadButton(
                topLabel: 'Upload Proof of a Active insurance policy.',
                title: 'Insurance-policy.pdf',
                icon: Icons.upload,
                onTap: () {},
              ),


              CustomChecked(
                title: 'Do you have a valid Motor Carrier (MC) number?*',
                selected: mCNumber,
                onChanged: (val) {
                  setState(() {
                    mCNumber = val;
                  });
                },
              ),


              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _mCNumberTEController,
                labelText: 'MC Number',
                hintText: 'MC Number',
              ),



              CustomUploadButton(
                topLabel: 'Upload Proof of MC authority',
                title: 'mc.pdf',
                icon: Icons.upload,
                onTap: () {},
              ),


              SizedBox(height: 44.h),
              Center(
                  child: CustomButton(
                      title: 'Save and Next',
                      onpress: () {
                        if(_globalKey.currentState!.validate()) return;
                        context.pushNamed(AppRoutes.vehicleEquipmentScreen);
                      })),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
