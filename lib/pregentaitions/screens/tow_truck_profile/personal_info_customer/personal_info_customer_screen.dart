import 'dart:io';

import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:autorevive/services/api_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/mechanic_controller.dart';
import '../../../../controllers/upload_controller.dart';
import '../../../../core/config/app_routes/app_routes.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../helpers/toast_message_helper.dart';
import '../../../widgets/cachanetwork_image.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class PersonalInfoCustomerScreen extends StatefulWidget {

   const PersonalInfoCustomerScreen({super.key});

  @override
  State<PersonalInfoCustomerScreen> createState() =>
      _PersonalInfoCustomerScreenState();
}

class _PersonalInfoCustomerScreenState extends State<PersonalInfoCustomerScreen> {


  MechanicController mechanicController = Get.put(MechanicController());
  UploadController uploadController = Get.put(UploadController());

  final TextEditingController fullNameCtrl = TextEditingController();
  final TextEditingController platformCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();
  final TextEditingController currentAddressCtrl = TextEditingController();
  bool? validUSDOTNumber;
  bool? readOnly = true;
  String appbarTitle = "Edit Information";

  final List<String> platForm = [
    'In shop',
    'On Site',
  ];


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Map routerData = GoRouterState.of(context).extra as Map;

    if(fullNameCtrl.text == null || fullNameCtrl.text == ""){
      fullNameCtrl.text = routerData["name"];
      emailCtrl.text = routerData["email"];
      phoneNoCtrl.text = routerData["phone"];
      currentAddressCtrl.text = routerData["address"];
    }

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
                                imageUrl: "${ApiConstants.imageBaseUrl}/${routerData["image"]}",
                                height: 128.h,
                                width: 128.w,
                              ),
                      ),

                      /// <<<<=========================>>>> Camera icon on top of the image <<<=======================================>>
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
                  labelText: "Full Name"),

              ///<<<=============>>> Email Filed <<<===============>>>

              CustomTextField(
                  controller: emailCtrl,
                  hintText: "Enter E-mail",
                  labelText: "Email",
                  readOnly: true,
                  isEmail: true),

              ///<<<=============>>> Phone Filed <<<===============>>>

              CustomTextField(
                  controller: phoneNoCtrl,
                  labelText: "Phone No.",
                  hintText: "Enter your phone number"),

              ///<<<=============>>> Address Filed <<<===============>>>

              CustomTextField(
                controller: currentAddressCtrl,
                hintText: "Enter Current Address",
                labelText: "Current Address",
              ),


              ///<<<=============>>> DRIVING LICENSE OR PASSPORT Filed <<<===============>>>

              CustomUploadButton(
                topLabel: 'Upload driving license or passport',
                title: pdfFile?.toString() ?? '${routerData["license"]}',
                icon: Icons.upload,
                onTap: importPdf,
              ),



              SizedBox(height: 100.h),

              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              Obx(()=>
                 CustomButton(
                   loading: mechanicController.updateProfileCustomerLoading.value,
                  title:   "Update Profile",
                  onpress: () {
                   // appbarTitle == "Edit Profile" ? null : context.pushNamed(AppRoutes.personalInfoCustomerScreen, extra: true);

                    mechanicController.customerUpdateProfile(
                      name: fullNameCtrl.text,
                      address: currentAddressCtrl.text,
                      phone: phoneNoCtrl.text,
                      passPort: filePath ?? '${routerData["license"]}',
                      profileImage: profileImagePath,
                      context: context
                    );
                  },
                ),
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
  String? profileImagePath;

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {


      Navigator.pop(context);

        profileImagePath = await uploadController.uploadFile(file: File(pickedFile.path));
        selectedImage = File(pickedFile.path);
      setState(() { });

    }
  }

//==================================> Camera <===============================

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      Navigator.pop(context);

        profileImagePath = await uploadController.uploadFile(file: File(pickedFile.path));
        selectedImage = File(pickedFile.path);
      setState(() { });

    }
  }



  File? pdfFile;
  String? filePath;

  Future<void> importPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);


        filePath = await uploadController.uploadFile(file: selectedFile);
        pdfFile = selectedFile;
      setState(() {  });
    }
    else {
      ToastMessageHelper.showToastMessage("No file selected.");
    }
  }
}
