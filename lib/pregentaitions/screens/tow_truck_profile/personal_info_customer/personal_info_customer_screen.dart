import 'dart:io';

import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/config/app_routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../widgets/cachanetwork_image.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class PersonalInfoCustomerScreen extends StatefulWidget {
  final bool isEditable;
   const PersonalInfoCustomerScreen({super.key, this.isEditable = false});

  @override
  State<PersonalInfoCustomerScreen> createState() =>
      _PersonalInfoCustomerScreenState();
}

class _PersonalInfoCustomerScreenState
    extends State<PersonalInfoCustomerScreen> {
  final TextEditingController fullNameCtrl = TextEditingController();
  final TextEditingController platformCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();
  final TextEditingController currentAddressCtrl = TextEditingController();
  bool? validUSDOTNumber;
  bool? readOnly = true;
  String appbarTitle = "Personal Information";

  final List<String> platForm = [
    'In shop',
    'On Site',
  ];


  @override
  void initState() {
    super.initState();
    readOnly = !widget.isEditable;
    appbarTitle = widget.isEditable ? "Edit Profile" : "Personal Information";
  }


  @override
  void dispose() {
    readOnly = true;
    appbarTitle = "Personal Information";
    setState(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: appbarTitle.toString(),
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
              SizedBox(height: 30.h),

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
                            color: AppColors.primaryColor,
                            width: 3,
                          ),
                        ),
                        child: selectedImage != null
                            ? ClipOval(
                                child: Image.file(selectedImage!,
                                    fit: BoxFit.cover))
                            : CustomNetworkImage(
                                boxShape: BoxShape.circle,
                                imageUrl:
                                    "https://randomuser.me/api/portraits/men/45.jpg",
                                height: 128.h,
                                width: 128.w,
                              ),
                      ),

                      /// <<<<=========================>>>> Camera icon on top of the image <<<=======================================>>
                      if(appbarTitle == "Edit Profile") Positioned(
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
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.fontColorFFFFFF,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 8.h),
              ///<<<=============>>> Name Filed <<<===============>>>

              CustomTextField(
                  controller: fullNameCtrl,
                  hintText: "Enter your name",
                  readOnly: readOnly,
                  labelText: "Full Name"),

              ///<<<=============>>> Email Filed <<<===============>>>

              CustomTextField(
                  controller: emailCtrl,
                  hintText: "Enter E-mail",
                  labelText: "Email",
                  readOnly: readOnly,
                  isEmail: true),

              ///<<<=============>>> Phone Filed <<<===============>>>

              CustomTextField(
                  controller: phoneNoCtrl,
                  readOnly: readOnly,
                  labelText: "Phone No.",
                  hintText: "Enter your phone number"),

              ///<<<=============>>> Address Filed <<<===============>>>

              CustomTextField(
                controller: currentAddressCtrl,
                hintText: "Enter Current Address",
                labelText: "Current Address",
                readOnly: readOnly,
              ),

              CustomUploadButton(title: "License.pdf", onTap: () {}),

              SizedBox(height: 100.h),

              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              CustomButton(
                title:  appbarTitle == "Edit Profile" ? "Update Profile" : "Edit Profile",
                onpress: () {
                 appbarTitle == "Edit Profile" ? null : context.pushNamed(AppRoutes.personalInfoCustomerScreen, extra: true);

                },
              ),
              SizedBox(height: 20.h),
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
              border: const Border(
                  top: BorderSide(color: AppColors.primaryColor, width: 0.25)),
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
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

//==================================> Camera <===============================

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
}
