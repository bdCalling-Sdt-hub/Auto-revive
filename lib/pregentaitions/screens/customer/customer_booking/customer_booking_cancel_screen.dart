import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerBookingCancelScreen extends StatelessWidget {
  CustomerBookingCancelScreen({super.key});

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();
  final TextEditingController reasonCtrl = TextEditingController();
  final TextEditingController ratingCommentCtrl = TextEditingController();

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



                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: CustomText(
                              text: "Kindly Give Feedback",
                              color: Colors.black,
                            ),
                          ),
                        ),
                         GestureDetector(
                             onTap: () {

                             },
                             child: const Icon(Icons.cancel_outlined, color: Colors.red)),
                      ],
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            child: RatingBar(
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              onRatingChanged: (value) => debugPrint('$value'),
                              initialRating: 3,
                              maxRating: 5,
                            ),
                          ),
                          SizedBox(height: 35.h),
                          CustomText(text: "Leave A Comment For User.", color: Colors.black),
                          SizedBox(height: 15.h),
                          CustomTextField(
                            controller: ratingCommentCtrl,
                            hintText: "Enter Your Valuable Comment",
                          ),
                          SizedBox(height: 16.h),
                          CustomButton(
                            title: "Submit",
                            onpress: () {
                              Navigator.of(context).pop(); // Close the dialog
                              // Handle your submit logic here
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );



              }),
          
          
              SizedBox(height: 50.h)
            ],
          ),
        ),
      ),
    );
  }
}
