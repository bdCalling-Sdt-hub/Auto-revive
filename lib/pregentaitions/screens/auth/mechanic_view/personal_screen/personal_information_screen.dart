import 'dart:io';

import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../global/custom_assets/assets.gen.dart';
import '../../../../widgets/cachanetwork_image.dart';

class PersonalInformationScreen extends StatefulWidget {
  PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {





  final TextEditingController fullNameCtrl = TextEditingController();
  final TextEditingController platformCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();
  final TextEditingController currentAddressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: "Personal Information",
          fontsize: 20.sp,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.start,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              ///<<<=============>>> PERCENT <<<===============>>>


              /// <<<=============>>> Image and camera upload section <<<=============>>>
              Center(
                child: GestureDetector(
                  onTap: () {
                    showImagePickerOption(context);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Profile image with border
                      Container(
                        width: 104.w,
                        height: 104.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.cameBorderColorFA5654,
                            width: 3,
                          ),
                        ),
                        child: selectedImage != null
                            ? ClipOval(child: Image.file(selectedImage!, fit: BoxFit.cover))
                            : CustomNetworkImage(
                          boxShape: BoxShape.circle,
                          imageUrl: "",
                          height: 128.h,
                          width: 128.w,
                        ),
                      ),
                      // Camera icon on top of the image
                      Positioned(
                        top: 67.h,
                        left: 42.w,
                        child: Container(
                          width: 26.58.w,
                          height: 26.58.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color:AppColors.fontColorFFFFFF,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 38.h),

              ///<<<=============>>> Name Filed <<<===============>>>

              CustomText(
                  text: "Full Name",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(controller: fullNameCtrl, hintText: "Enter your name"),
              ///<<<=============>>> Platform Filed <<<===============>>>
              SizedBox(height: 11.h),
              CustomText(
                  text: "Platform",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              // Platform dropdown or text field (use if needed)
              CustomTextField(
                controller: platformCtrl,
                hintText: "Enter Platform",
                suffixIcon:  Assets.icons.selectIcon.svg(),
                // prefixIcon: Assets.icons.platform.svg(),
              ),
              SizedBox(height: 11.h),

              ///<<<=============>>> Email Filed <<<===============>>>
              CustomText(
                  text: "Email",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(
                  controller: emailCtrl,
                  hintText: "Enter E-mail",
                  // prefixIcon: Assets.icons.mail.svg(),
                  isEmail: true),
              SizedBox(height: 11.h),

              ///<<<=============>>> Phone Filed <<<===============>>>
              CustomText(
                  text: "Phone No.",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(
                controller: phoneNoCtrl,
                hintText: "Enter Phone Number",
                // prefixIcon: Assets.icons.phone.svg(),
              ),
              SizedBox(height: 11.h),

              ///<<<=============>>> Address Filed <<<===============>>>
              CustomText(
                  text: "Current Address",
                  fontsize: 16.h,
                  color: const Color(0xff222222),
                  bottom: 6.h),
              CustomTextField(
                controller: currentAddressCtrl,
                hintText: "Enter Current Address",

              ),

              SizedBox(height: 50.h),

              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              CustomButton(
                title: "Save and Next",
                onpress: () {
                  // Action after saving data and moving to next screen
                  context.pushNamed(AppRoutes.resetPasswordScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }




//==================================> ShowImagePickerOption Function <===============================

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white.withOpacity(.5),
        elevation: 3,
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
              border: const Border(top: BorderSide(color: AppColors.primaryColor, width: 0.25)),
              borderRadius: BorderRadius.circular(20.r),

            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 9.2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Icon(
                                Icons.image,
                                size: 50.w,
                              ),
                              CustomText(text: 'Gallery')
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImageFromCamera();
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 50.w,
                              ),
                              CustomText(text: 'Camera')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }


  //==================================> Gallery <===============================

  File? selectedImage;

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

//==================================> Camera <===============================

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }



}

