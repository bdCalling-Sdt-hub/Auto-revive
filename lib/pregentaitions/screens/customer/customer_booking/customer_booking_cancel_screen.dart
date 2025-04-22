import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerBookingCancelScreen extends StatelessWidget {
  CustomerBookingCancelScreen({super.key});

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();
  final TextEditingController reasonCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Cancel"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text:
                      "\"Cancel the order and initiate the refund process immediately.\"",
                  maxline: 2,
                  color: Colors.black),
              SizedBox(height: 24.h),
              CustomTextField(
                controller: nameCtrl,
                labelText: "Mechanic Name",
                hintText: "Enter mechanic name",
              ),
              CustomTextField(
                controller: emailCtrl,
                labelText: "Mechanic Email",
                hintText: "Enter mechanic email",
                isEmail: true,
              ),
              CustomTextField(
                controller: phoneNoCtrl,
                labelText: "Mechanic Phone No",
                hintText: "Enter mechanic phone no",
                keyboardType: TextInputType.number,
              ),
          
          
          
              CustomText(text: "Upload Car Images", color: Colors.black),
          
              CustomUploadButton(title: "Images.jpg", onTap: () {
          
              }),
          
          
              CustomTextField(
                  labelText: "Write your reason",
                  controller: reasonCtrl,
                  maxLine: 10,
                  hintText: "Write your reason this box. Why cancel and refund...",
              ),
          
          
          
              CustomButton(title: "Submit", onpress: () {
          
              }),
          
          
              SizedBox(height: 50.h)
            ],
          ),
        ),
      ),
    );
  }
}
