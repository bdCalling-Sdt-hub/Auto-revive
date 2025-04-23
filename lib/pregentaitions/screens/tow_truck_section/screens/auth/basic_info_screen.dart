import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_phone_number_picker.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
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
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
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
                hintText: 'name',
              ),


              CustomTextField(
                controller: _addressTEController,
                labelText: 'Business Address',
                hintText: 'USA, New York',
              ),


              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
                controller: _emailTEController,
                labelText: 'Email',
                hintText: 'email',
              ),


              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _priceTEController,
                labelText: 'Price Per Mile',
                hintText: 'price',
              ),



              /// ++++++++++++++++++++++  phone number  ==================>
              CustomPhoneNumberPicker(controller: _phoneTEController, lebelText: 'Phone No.',),


              CustomTextField(
                controller: _lLCTEController,
                labelText: 'Partner with LLC for Reliable Towing Service',
                hintText: 'David William LLC',
              ),

              SizedBox(height: 44.h),


              Center(child: CustomButton(title: 'Save and Next',
                  onpress: (){
                if(_formKey.currentState!.validate()) return;
                context.pushNamed(AppRoutes.companyInformationScreen);

              })),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
