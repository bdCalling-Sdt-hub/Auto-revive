import 'dart:io';

import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/customer/customer_booking_controller.dart';

class CustomerBookingCancelScreen extends StatefulWidget {
  CustomerBookingCancelScreen({super.key});

  @override
  State<CustomerBookingCancelScreen> createState() => _CustomerBookingCancelScreenState();
}

class _CustomerBookingCancelScreenState extends State<CustomerBookingCancelScreen> {


  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();
  final TextEditingController reasonCtrl = TextEditingController();
  final TextEditingController ratingCommentCtrl = TextEditingController();
  CustomerBookingController bookingController = Get.find<CustomerBookingController>();

  @override
  Widget build(BuildContext context) {
    Map routeData = GoRouterState.of(context).extra as Map;
    return Scaffold(
      appBar: const CustomAppBar(title: "Refund Request"),
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
              SizedBox(height: 40.h),

              CustomText(text: "Upload Car Images", color: Colors.black),

              CustomUploadButton(title: "Images.jpg", onTap: ()=> importImage()),


              SizedBox(
                height: carImages.length * 100.h,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: carImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 1,
                        child: ListTile(
                          contentPadding:  EdgeInsets.all(10.r),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              carImages[index],
                              width: 80.w,
                              height: 60.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: CustomText(
                           text: p.basename(carImages[index].path),
                            maxline: 1,
                            fontsize: 18.h,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeImage(index),
                          ),
                        ),
                      ),
                    );
                  },
                ),

              ),

              CustomTextField(
                  labelText: "Write your reason",
                  controller: reasonCtrl,
                  maxLine: 10,
                  hintText: "Write your reason this box. Why cancel and refund...",
              ),



              CustomButton(title: "Submit", onpress: () {


                bookingController.cancelPayment(images: carImages, type: "service", jobId: routeData["id"], refundDetails: reasonCtrl.text);


              }),


              SizedBox(height: 50.h)
            ],
          ),
        ),
      ),
    );
  }

  List<File> carImages = [];

  Future<void> importImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      List<File> files = pickedFiles.map((xFile) => File(xFile.path)).toList();

      setState(() {
        carImages.addAll(files);
        if (carImages.length > 4) {
          carImages = carImages.sublist(0, 4);
        }
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      carImages.removeAt(index);
    });
  }

}
