import 'dart:io';
import 'package:autorevive/pregentaitions/widgets/CustomChecked.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../controllers/towTrack/registration_tow_track_controller.dart';
import '../../../../../controllers/upload_controller.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../../helpers/toast_message_helper.dart';

class LicensingAndComplianceScreen extends StatefulWidget {
  const LicensingAndComplianceScreen({super.key});

  @override
  State<LicensingAndComplianceScreen> createState() =>
      _LicensingAndComplianceScreenState();
}

class _LicensingAndComplianceScreenState extends State<LicensingAndComplianceScreen> {

  TowTrackController towTrackController = Get.put(TowTrackController());
  UploadController uploadController = Get.put(UploadController());

  final TextEditingController _uSDOTNumberTEController = TextEditingController();
  final TextEditingController _policyNumberTEController = TextEditingController();
  final TextEditingController _coverageLimitsTEController = TextEditingController();
  final TextEditingController _mCNumberTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  RxString registrationUrl = ''.obs;
  RxString insurancePolicyUrl = ''.obs;
  RxString mcUrl = ''.obs;
  bool? validUSDOTNumber;
  bool? coverageNumber;
  bool? mCNumber;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra;
      final Map routeData = extra is Map ? extra : {};

      _uSDOTNumberTEController.text = routeData['usDotNo'] ?? '';
      _policyNumberTEController.text = routeData['policyNo'] ?? '';
      _coverageLimitsTEController.text = routeData['policyLimit']?.toString() ?? '';
      _mCNumberTEController.text = routeData['mcNo'] ?? '';

      registrationUrl.value = routeData['usDotFile'] ?? '';
      insurancePolicyUrl.value = routeData['policyFile'] ?? '';
      mcUrl.value = routeData['mcFile'] ?? '';

      validUSDOTNumber = (routeData['usDotNo'] ?? '').toString().isNotEmpty;
      coverageNumber = (routeData['policyNo'] ?? '').toString().isNotEmpty;
      mCNumber = (routeData['mcNo'] ?? '').toString().isNotEmpty;

      setState(() {
        isLoading = false;
      });
    });


    towTrackController.getTowTrackProfile();
  }






  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    final Map routeData = extra is Map ? extra : {};
    final bool isEdit = routeData['isEdit'] ?? false;
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

              /// =======================================> Dot Number ===================================>
              CustomChecked(
                title: 'Do you have a valid US-DOT number? *',
                selected: validUSDOTNumber,
                onChanged: (val) {
                  setState(() {
                    validUSDOTNumber = val;
                  });
                },
              ),
            if (validUSDOTNumber == true) ...[ CustomTextField(
                keyboardType: TextInputType.number,
                controller: _uSDOTNumberTEController,
                labelText: 'US-DOT Number',
                hintText: 'US-DOT Number',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
              ),
              CustomUploadButton(
                topLabel: 'Do you have commercial insurance coverage?*',
                title: registrationUrl.value.isNotEmpty
                    ? 'DOT registration.pdf'
                    : 'Upload DOT registration',
                icon: Icons.upload,
                onTap: () => importPdf(target: 'dot'),
              ),
            ],

              /// =======================================> Commercial Insurance ===================================>

              CustomChecked(
                title: 'Do you have commercial insurance coverage?*',
                selected: coverageNumber,
                onChanged: (val) {
                  setState(() {
                    coverageNumber = val;
                  });
                },
              ),
              if (coverageNumber == true) ...[
                CustomTextField(
                keyboardType: TextInputType.number,
                controller: _policyNumberTEController,
                labelText: 'Policy Number',
                hintText: 'Policy Number',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
              ),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _coverageLimitsTEController,
                labelText: 'Coverage Limits',
                hintText: 'Coverage Limits',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
              ),
                CustomUploadButton(
                  topLabel: 'Upload Proof of a Active insurance policy.',
                  title: insurancePolicyUrl.value.isNotEmpty
                      ? 'insurancePolicy.pdf'
                      : 'Upload insurance policy',
                  icon: Icons.upload,
                  onTap: () => importPdf(target: 'insurance'),
                ),],

              /// =======================================> MC Number ===================================>
              CustomChecked(
                title: 'Do you have a valid Motor Carrier (MC) number?*',
                selected: mCNumber,
                onChanged: (val) {
                  setState(() {
                    mCNumber = val;
                  });
                },
              ),
    if (mCNumber == true) ...[
      CustomTextField(
                keyboardType: TextInputType.number,
                controller: _mCNumberTEController,
                labelText: 'MC Number',
                hintText: 'MC Number',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
              ),
      CustomUploadButton(
        topLabel: 'Upload Proof of MC authority',
        title: mcUrl.value.isNotEmpty
            ? 'mc.pdf'
            : 'Upload mc',
        icon: Icons.upload,
        onTap: () => importPdf(target: 'mc'),
      ),],


              SizedBox(height: 44.h),
              Obx(()=>
                CustomButton(
                  loading: towTrackController.licensingComplianceLoading.value,
                    title: isEdit ? "Edit" : "Save and Next",
                    onpress: () async{
                      if(_globalKey.currentState!.validate()){
                        if (validUSDOTNumber == true && registrationUrl.value.isEmpty) {
                          ToastMessageHelper.showToastMessage("Please upload DOT registration.", title: 'Attention');
                          return;
                        }
                        if (coverageNumber == true && insurancePolicyUrl.value.isEmpty) {
                          ToastMessageHelper.showToastMessage("Please upload insurance policy.", title: 'Attention');
                          return;
                        }
                        if (mCNumber == true && mcUrl.value.isEmpty) {
                          ToastMessageHelper.showToastMessage("Please upload MC file.", title: 'Attention');
                          return;
                        }

                        final int? policyLimit = int.tryParse(_coverageLimitsTEController.text.trim());
                        final success = await  towTrackController.licensingCompliance(
                            policyNo: _policyNumberTEController.text.trim(),
                            policyLimit: policyLimit,
                            usDotFile: registrationUrl.value,
                            policyFile: insurancePolicyUrl.value,
                            mcNo: _mCNumberTEController.text.trim(),
                            usDotNo: _uSDOTNumberTEController.text.trim(),
                            mcFile: mcUrl.value,
                            context: context);
                        if (success) {
                          isEdit
                              ? context.pop(true)
                              :  context.pushNamed(AppRoutes.vehicleEquipmentScreen);
                        }
                      }

                    }


                    ),),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> importPdf({required String target}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);
      String? uploadedPath = await uploadController.uploadFile(file: selectedFile);

      if (uploadedPath != null) {
        if (target == 'dot') {
          registrationUrl.value = uploadedPath;
        } else if (target == 'insurance') {
          insurancePolicyUrl.value = uploadedPath;
        } else if (target == 'mc') {
          mcUrl.value = uploadedPath;
        }
      } else {
        ToastMessageHelper.showToastMessage("File upload failed.");
      }
    } else {
      ToastMessageHelper.showToastMessage("No file selected.");
    }
  }


// Future<void> importPdf({required bool isRegistration}) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //
  //   if (result != null && result.files.isNotEmpty) {
  //     File selectedFile = File(result.files.single.path!);
  //     String? uploadedPath = await uploadController.uploadFile(file: selectedFile);
  //     if (uploadedPath != null) {
  //       if (isRegistration) {
  //         registrationUrl.value = uploadedPath;
  //       } else  {
  //         insurancePolicyUrl.value = uploadedPath;
  //       }
  //     } else {
  //       mcUrl.value = uploadedPath!;
  //     }
  //   } else {
  //     ToastMessageHelper.showToastMessage("No file selected.");
  //   }
  // }


}
