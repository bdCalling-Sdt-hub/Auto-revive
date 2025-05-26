import 'dart:io';

import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_checkbox_list.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:go_router/go_router.dart';

import '../../../../../controllers/towTrack/registration_tow_track_controller.dart';
import '../../../../../controllers/upload_controller.dart';
import '../../../../../helpers/toast_message_helper.dart';

class BusinessRequirementScreen extends StatefulWidget {
  const BusinessRequirementScreen({super.key});

  @override
  State<BusinessRequirementScreen> createState() => _BusinessRequirementScreenState();
}

class _BusinessRequirementScreenState extends State<BusinessRequirementScreen> {

  UploadController uploadController = Get.put(UploadController());
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _dateTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TowTrackController towTrackController = Get.put(TowTrackController());

  RxString signatureUrl = ''.obs;

  final Map<String, bool> _services = {
    'Maintain active DOT registration & insurance coverage at all times.': false,
    'Adhere to all local, state, and federal regulations for towing operations.': false,
    'Provide timely and professional service': false,
    'Maintain clean and well-maintained tow trucks and equipment.': false,
    'Communicate accurate ETAs and service updates.': false,
    'Submit a live walk-around video showing that all trucks meet operational standards.': false,
    'I certify that the information provided is accurate and that my company meets all requirements for partnering with Fix It LLC.': false,
  };


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          centerTitle: false,
          title: CustomText(
            textAlign: TextAlign.start,
            maxline: 2,
            text: "Business requirements and agreements",
            fontsize: 20.sp,
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomLinearIndicator(
                progressValue: 0.94,
                label: 100,
              ),
              SizedBox(height: 24.h),
              CustomText(
                textAlign: TextAlign.start,
                maxline: 2,
                text: 'By applying to work with Fix It LLC, you agree to the following..',
                bottom: 6.h,
              ),
              CustomCheckboxList(
                isAllChecked: true,
                items: _services,
              ),

              SizedBox(height: 10.h),

              CustomTextField(
                controller: _nameTEController,
                labelText: 'Authorized or Representative name',
                hintText: 'Authorized or Representative name',
              ),

              CustomTextField(
                controller: _titleTEController,
                labelText: 'Authorized or Representative title',
                hintText: 'Authorized or Representative title',
              ),



              CustomUploadButton(
                topLabel: 'Signarure',
                  title: 'signature.jpg',
                  onTap: ()=> importPdf(isSignature: true)),

              CustomTextField(
                readOnly: true,
                onTap: _selectDate,
                controller: _dateTEController,
                labelText: 'Date',
                hintText: 'Date',
                suffixIcon: const Icon(Icons.date_range_outlined),
              ),

              SizedBox(height: 44.h),
              Obx(()=>
                CustomButton(
                  loading: towTrackController.businessRequirementsLoading.value,
                    title: 'Submit',
                    onpress: () {
                      if(_globalKey.currentState!.validate()){

                        if (signatureUrl.value.isEmpty) {
                          ToastMessageHelper.showToastMessage("Please upload Signature", title: 'Attention');
                          return;
                        }

                        if (!_services.values.any((v) => v)) {
                          ToastMessageHelper.showToastMessage("Please select all services LLC", title: 'Attention');
                          return;
                        }

                        towTrackController.businessRequirements(
                          authName: _nameTEController.text.trim(),
                            authTitle: _titleTEController.text.trim(),
                            authSignature: signatureUrl.value,
                            authDate: _dateTEController.text.trim(),
                            context: context);


                      } return;
                    }),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> importPdf({required bool isSignature}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);
      String? uploadedPath = await uploadController.uploadFile(file: selectedFile);
      if (uploadedPath != null) {
        if (isSignature) {
          signatureUrl.value = uploadedPath;
        }
      }
    } else {
      ToastMessageHelper.showToastMessage("No file selected.");
    }
  }
  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      setState(() {
        _dateTEController.text = formattedDate;
      });
    }
  }

}
