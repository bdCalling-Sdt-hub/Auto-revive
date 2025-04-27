import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_popup_menu.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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


  final List<String> towTruckList = [
    "Flatbed",
    "Wrecker",
    'Heavy - Duty',
    'Medium - Duty',
    'Light - Duty',
    'Other',
  ];




  @override
  Widget build(BuildContext context) {
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
          child: Column(
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
                onTap: _selectDate,
                readOnly: true,
                controller: _makingYearTEController,
                labelText: 'Making of the year..',
                hintText: 'Making of the year..',
                suffixIcon: IconButton(
                    onPressed: _selectDate,
                    icon: const Icon(
                      Icons.date_range_outlined,
                      color: Colors.black,
                    )),
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
                controller: _vehicleWeightTEController,
                labelText: 'Gross Vehicle Weight Rating (GVWR)',
                hintText: 'Gross Vehicle Weight Rating (GVWR)',
              ),

              CustomTextField(
                readOnly: true,
                controller: _typeTowTruckTEController,
                labelText: 'Type of tow truck',
                hintText: 'Type of tow truck',
                suffixIcon: CustomPopupMenu(
                  items: towTruckList,
                  onSelected: (val) {
                    _typeTowTruckTEController.text = val;
                  },
                ),
              ),
              CustomUploadButton(
                topLabel: 'Upload walk around video of your tow truck',
                title: 'towtruck.mp4',
                icon: Icons.upload,
                onTap: () {},
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
              Center(
                  child: CustomButton(
                      title: 'Save and Next',
                      onpress: () {
                        if(_globalKey.currentState!.validate()) return;
                        context.pushNamed(AppRoutes.serviceCoverageScreen);
                      })),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
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
        _makingYearTEController.text = formattedDate;
      });
    }
  }
}
