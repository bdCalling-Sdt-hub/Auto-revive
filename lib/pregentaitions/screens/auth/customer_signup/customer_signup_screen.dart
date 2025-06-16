import 'dart:io';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../controllers/upload_controller.dart';
import '../../../../helpers/toast_message_helper.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_upload_button.dart';

class CustomerSignupScreen extends StatefulWidget {
  CustomerSignupScreen({super.key});

  @override
  State<CustomerSignupScreen> createState() => _CustomerSignupScreenState();
}

class _CustomerSignupScreenState extends State<CustomerSignupScreen> {

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();


  UploadController uploadController = Get.put(UploadController());
  AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  RxBool isMatched = false.obs;
  RxBool isObscureConfirmPassword = true.obs;
  toggleIsObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }
  ismMatchedColor() {isMatched.value = !isMatched.value;}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: CustomText(text: "As a Customer", fontsize: 18.h),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48.h),

                ///<<<=============>>> Name Filed <<<===============>>>

                CustomText(
                    text: "Your Name",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),
                CustomTextField(controller: nameCtrl, hintText: "Enter your name"),




                ///<<<=============>>> Email Filed <<<===============>>>

                CustomText(
                    text: "E-mail",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),
                CustomTextField(controller: emailCtrl, hintText: "Enter your e-mail"),



                ///<<<=============>>> PHONE FIELD <<<===============>>>

                CustomText(
                    text: "Phone No.",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),

                CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: phoneCtrl,
                    hintText: "Enter your phone",
                   inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    } else if (value.length < 11) {
                      return 'Phone number must be 11 digits';
                    } else if (value.length > 11) {
                      return 'Phone number cannot exceed 11 digits';
                    }
                    return null;
                  },
                ),



                ///<<<=============>>> ADDRESS Filed <<<===============>>>

                CustomText(
                    text: "Address",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),
                CustomTextField(controller: addressCtrl, hintText: "Enter your address"),



                ///<<<=============>>> DRIVING LICENSE OR PASSPORT Filed <<<===============>>>

                CustomText(
                    text: "Upload driving license or passport",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),

                CustomUploadButton(
                  title: pdfFile?.toString() ?? 'Upload.pdf',
                  icon: Icons.upload,
                  onTap: importPdf,
                ),




                ///<<<=============>>> PASSWORD Filed <<<===============>>>

                CustomText(
                    text: "Password",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),
                CustomTextField(controller: passwordCtrl, hintText: "Enter your password", prefixIcon: Assets.icons.key.svg(), isPassword: true),




                ///<<<=============>>>CONFIRM PASSWORD Filed <<<===============>>>

                CustomText(
                    text: "Confirm Password",
                    fontsize: 16.h,
                    color: const Color(0xff222222),
                    bottom: 6.h),
                CustomTextField(controller: confirmPasswordCtrl, hintText: "Re-enter your password",  prefixIcon: Assets.icons.key.svg(), isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      Future.delayed(Duration.zero, () => isMatched.value = false);
                      return "Please enter your confirm password";
                    } else if (passwordCtrl.text == value) {
                      Future.delayed(Duration.zero, () => isMatched.value = true);
                      return null;
                    } else {
                      Future.delayed(Duration.zero, () => isMatched.value = false);
                      return "Password Not Matching";
                    }
                  },
                  onChanged: (value) {
                    isMatched.value = passwordCtrl.text == value;
                  },
                ),
                Obx(() => Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:  EdgeInsets.only(top: 15.h),
                      child: CustomText(text: isMatched.value ? "Password Matched" : "",color: Colors.green,fontsize: 14.sp,),
                    ))),
                SizedBox(height: 10.h),
                Obx(()=>
                   CustomButton(
                     loading: authController.signUpLoading.value,
                    title: "Sign Up",
                    onpress: () {
                      if(fromKey.currentState!.validate()){
                          authController.handleSignUp(
                              name: nameCtrl.text,
                              email: emailCtrl.text,
                              phone: phoneCtrl.text,
                              password: passwordCtrl.text.trim(),
                              confirmPassword: confirmPasswordCtrl.text.trim(),
                            filePath: pdfFile,
                            context: context,
                            screenType: "user"
                          );
                      }
                  },),
                ),
                SizedBox(height: 50.h)
              ],
            ),
          ),
        ),
      ),
    );

  }


  // Future<void> importPdf() async {
  //   FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  //
  //   if (result != null && result.files.isNotEmpty) {
  //     folderController.uploadFile(filesToUpload: [File(result.files.single.path!)]);
  //   }
  // }

  File? pdfFile;

  Future<void> importPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);

      pdfFile = selectedFile;
      setState(() {

      });
      // // String? uploadedPath = await uploadController.uploadFile(file: selectedFile);
      // if (uploadedPath != null) {
      //   // ToastMessageHelper.showToastMessage("File uploaded: ${uploadedPath.split('/').last}");
      // } else {
      //   ToastMessageHelper.showToastMessage("File upload failed.");
      // }
    }
    else {
      ToastMessageHelper.showToastMessage("No file selected.");
    }
  }



}
