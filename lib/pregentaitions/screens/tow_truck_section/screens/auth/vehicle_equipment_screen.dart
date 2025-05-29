import 'dart:io';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_popup_menu.dart';
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
import 'package:shimmer/shimmer.dart';
import '../../../../../controllers/towTrack/registration_tow_track_controller.dart';
import '../../../../../controllers/upload_controller.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../../helpers/toast_message_helper.dart';
import '../../../../../models/car_model.dart';

class VehicleEquipmentScreen extends StatefulWidget {
  const VehicleEquipmentScreen({super.key});

  @override
  State<VehicleEquipmentScreen> createState() => _VehicleEquipmentScreenState();
}

class _VehicleEquipmentScreenState extends State<VehicleEquipmentScreen> {

  final TextEditingController _makingYearTEController = TextEditingController();
  final TextEditingController _manufacturerTEController = TextEditingController();
  final TextEditingController _modelNumberTEController = TextEditingController();
  final TextEditingController _vehicleWeightTEController = TextEditingController();
  final TextEditingController _typeTowTruckTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TowTrackController towTrackController = Get.put(TowTrackController());
  UploadController uploadController = Get.put(UploadController());

  RxString videoUrl = ''.obs;

  final List<CarModel> typeTrack =  [
    CarModel(id: '1', adminId: 'admin123', name: 'flatbed', v: 0),
    CarModel(id: '2', adminId: 'admin123', name: 'wrecker', v: 0),
    CarModel(id: '3', adminId: 'admin456', name: 'heavy-duty', v: 0),
    CarModel(id: '4', adminId: 'admin456', name: 'medium-duty', v: 0),
    CarModel(id: '5', adminId: 'admin456', name: 'light-duty', v: 0),
    CarModel(id: '6', adminId: 'admin456', name: 'other', v: 0),
  ];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra;
      final Map routeData = extra is Map ? extra : {};

      _makingYearTEController.text = routeData['year']?.toString() ?? '';
      _manufacturerTEController.text = routeData['brand'] ?? '';
      _modelNumberTEController.text = routeData['modelNo'] ?? '';
      _vehicleWeightTEController.text = routeData['gvwr']?.toString() ?? '';
      _typeTowTruckTEController.text = routeData['type'] ?? '';
      videoUrl.value = routeData['video'] ?? '';

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isLoading = false;
        });
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
            text: "Vehicle and Equipment Verification",
            fontsize: 20.sp,
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: isLoading
              ? Column(
            children: List.generate(2, (_) => _buildShimmerVehicle()),
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomLinearIndicator(
                progressValue: 0.3,
              ),
              SizedBox(height: 24.h),
              CustomText(
                text: 'List of all tow trucks in your fleet.',
                bottom: 6.h,
              ),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _makingYearTEController,
                labelText: 'Making of the year..',
                hintText: 'Making of the year..',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
              ),
              CustomTextField(
                controller: _manufacturerTEController,
                labelText: 'The brand of manufacturer..',
                hintText: 'The brand of manufacturer..',
              ),
              CustomTextField(
                controller: _modelNumberTEController,
                labelText: 'Model number of truck..',
                hintText: 'Model number of truck..',
              ),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _vehicleWeightTEController,
                labelText: 'Gross Vehicle Weight Rating (GVWR)',
                hintText: 'Gross Vehicle Weight Rating (GVWR)',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],

              ),
        /// ===========================================> Type of Tow track ===================================>
              CustomTextField(
                readOnly: true,
                controller: _typeTowTruckTEController,
                labelText: 'Type of tow truck',
                hintText: 'Type of tow truck',
                suffixIcon: CustomPopupMenu(
                  items: typeTrack,
                    onSelected: (p0) {
                      final selectCarThis = typeTrack.firstWhere((x) => x.id == p0);
                      _typeTowTruckTEController.text = selectCarThis.name!;
                      setState(() {

                      });
                    }
                ),
              ),

              /// ======================================> Upload Video ==================================>
              CustomUploadButton(
                topLabel: 'Upload walk around video of your tow truck',
                title: 'towtruck.mp4',
                icon: Icons.upload,
                onTap: () => importPdf(isTruckVideo: true),
              ),
              SizedBox(height: 16.h),

              /// ++++++++++++++  Add more field ************************
              CustomContainer(
                onTap: () {},
                bordersColor: AppColors.pdfButtonColor,
                radiusAll: 8.r,
                width: double.infinity,
                height: 108.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                      size: 32.r,
                    ),
                    CustomText(text: 'Add more', top: 10.h),
                  ],
                ),
              ),
              SizedBox(height: 44.h),
              Obx(()=>
                CustomButton(
                  loading: towTrackController.vehiclesEquipmentLoading.value,
                    title:  isEdit ? "Edit" : "Save and Next",
                    onpress: () async{
                      if(_globalKey.currentState!.validate()){
                        final int? gvwr = int.tryParse(_vehicleWeightTEController.text.trim());
                        final int? year = int.tryParse(_makingYearTEController.text.trim());

                        if (videoUrl.value.isEmpty) {
                          ToastMessageHelper.showToastMessage("Please upload tow track video", title: 'Attention');
                        }
                        final success = await  towTrackController.vehiclesEquipment(
                            year: year,
                            brand: _manufacturerTEController.text.trim(),
                            modelNo: _modelNumberTEController.text.trim(),
                            gvwr: gvwr,
                            type: _typeTowTruckTEController.text.trim(),
                            video: videoUrl.value,
                            context: context);
                        if (success) {
                          isEdit
                              ? context.pop(true)
                              :  context.pushNamed(AppRoutes.serviceCoverageScreen);
                        }

                      }

                    }),),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildShimmerVehicle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kToolbarHeight + 20.h), // space for appbar

            // Company Name field shimmer
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 15.h),

            // Owner / Manager Name field shimmer
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 15.h),

            // Business Phone Number picker shimmer
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 15.h),

            // Business Email Address field shimmer
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 15.h),

            // Company Address field shimmer
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 15.h),

            // Website URL field shimmer
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 15.h),

            // Years in Business field shimmer
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 15.h),

            // Number of Tow Trucks and EIN number row shimmer
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Container(
                  width: 134.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),

            // Save and Next button shimmer
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }


  Future<void> importPdf({required bool isTruckVideo}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);
      String? uploadedPath = await uploadController.uploadFile(file: selectedFile);
      if (uploadedPath != null) {
        if (isTruckVideo) {
          videoUrl.value = uploadedPath;
        }
      }
    } else {
      ToastMessageHelper.showToastMessage("No file selected.");
    }
  }


}
