import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/CustomChecked.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/custom_checkbox_list.dart';
import '../../../../widgets/custom_linear_indicator.dart';
import '../../../../widgets/custom_text_field.dart';


class MechanicToolsEquipmentScreen extends StatefulWidget {
  MechanicToolsEquipmentScreen({super.key});
  @override
  State<MechanicToolsEquipmentScreen> createState() => _MechanicToolsEquipmentScreenState();
}
class _MechanicToolsEquipmentScreenState extends State<MechanicToolsEquipmentScreen> {


  final TextEditingController additionalToolsCtrl = TextEditingController();

  final Map<String, bool> _basicHandTools = {
    'Screwdrivers (Flat, Phillips, Torx).': false,
    'Pliers (Needle Nose, Slip Joint, Channel Lock,Wire Cutters).': false,
    'Ratchets (Standard & Flex Head).': false,
    'Wrenches (Combination, Box-End, Adjustable,Ratcheting).': false,
    'Allen Wrenches / Hex Keys.': false,
    'Pry Bars.': false,
    'Hammers (Ball Peen, Dead Blow, Rubber Mallet).': false,
    'Tape Measure & Utility Knife.': false,
  };
  final Map<String, bool> _socketRatchets = {
    '1/4” Drive Sockets (Standard & Deep).': false,
    '3/8” Drive Sockets (Standard & Deep).': false,
    '1/2” Drive Sockets (Standard & Deep).': false,
    '3/4” Drive Sockets (Standard & Deep).': false,
    '1” Drive Sockets (Standard & Deep).': false,
    'Universal Joints & Extensions (All Drive Sizes).': false,
    'Torque Wrench (1/4", 3/8", 1/2", 3/4", 1").': false,
  };
  final Map<String, bool> _powerPneumatic = {
    'Cordless Drill & Bits.': false,
    'Electric Ratchet (1/4", 3/8", 1/2").': false,
    'Pneumatic Ratchet (1/4", 3/8", 1/2").': false,
    'Impact Gun (1/4", 3/8", 1/2", 3/4", 1").': false,
    'Air Compressor & Air Hoses.': false,
  };
  final Map<String, bool> _diagnosticsEquipment = {
    'OBD2 Scanner.': false,
    'Diesel Engine Diagnostic Scanner (OEM orAftermarket).': false,
    'Battery Tester & Charger.': false,
    'Multi meter for Electrical Testing.").': false,
    'Fuel Pressure Tester.': false,
    'Cooling System Pressure Tester.': false,
  };
  final Map<String, bool> _liftingSupport = {
    'Hydraulic Jack (2-Ton, 10-Ton, 30-Ton).': false,
    'Jack Stands (Adjustable Height).': false,
    'Wheel Chocks.': false,
    'Creeper & Rolling Seat.").': false,
  };
  final Map<String, bool> _specialtyTools = {
    'Brake Service Tools (Brake Spoon, Brake SpringPliers, Caliper Compressor)': false,
    'Oil Filter Wrenches & Drain Pan.': false,
    'Hose Clamp Pliers.': false,
    'Pick Set (O-Ring & Seal Removal).").': false,
    'Welding Helmet, Gloves & Equipment.").': false,
    'Thread Chaser Set.").': false,
    'Tap & Die Set").': false,
    'Snap Ring Pliers").': false,
    'Wheel End Hub Sockets").': false,
  };

  bool? validUSDOTNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: CustomText(
          text: "Tools and Equipment",
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
              ///<<<=============>>> LinearIndicator <<<===============>>>
              const CustomLinearIndicator(
                progressValue: 0.03,
                label: 0,
              ),
              SizedBox(height: 29.h),
              ///<<<=============>>> CHECKED <<<===============>>>
              CustomText(
                text: 'Do you have own tools?',
                fontsize: 16.sp,
                textAlign: TextAlign.left,
              ),
              CustomChecked(
                selected: validUSDOTNumber,
                onChanged: (val) {
                  setState(() {
                    validUSDOTNumber = val;
                  });
                },
              ),
              ///<<<=============>>> Basic hand tools <<<===============>>>
              CustomText(text: 'Basic hand tools...',fontsize: 16.sp),
              CustomCheckboxList(
                isAllChecked: true,
                items: _basicHandTools,
              ),
              ///<<<=============>>> Sockets & Ratchets <<<===============>>>
              CustomText(text: 'Sockets & Ratchets...',fontsize: 16.sp),
              CustomCheckboxList(
                isAllChecked: true,
                items: _socketRatchets,
              ),
              ///<<<=============>>> Power & Pneumatic Tools <<<===============>>>
              CustomText(text: 'Power & Pneumatic Tools',fontsize: 16.sp),
              CustomCheckboxList(
                isAllChecked: true,
                items: _powerPneumatic,
              ),
              ///<<<=============>>> Diagnostics Equipment <<<===============>>>
              CustomText(text: 'Diagnostics Equipment',fontsize: 16.sp),
              CustomCheckboxList(
                isAllChecked: true,
                items: _diagnosticsEquipment,
              ),
              ///<<<=============>>> Lifting and Support Equipment <<<===============>>>
              CustomText(text: 'Lifting and Support Equipment',fontsize: 16.sp),
              CustomCheckboxList(
                isAllChecked: true,
                items: _liftingSupport,
              ),
              ///<<<=============>>> Specialty Tools <<<===============>>>
              CustomText(text: 'Specialty Tools',fontsize: 16.sp),
              CustomCheckboxList(
                isAllChecked: true,
                items: _specialtyTools,
              ),
              SizedBox(height: 20.h),
              ///<<<=============>>> Additional Tools <<<===============>>>
              CustomText(
                  text: "List any additional  tools you own",fontsize: 16.sp),
              SizedBox(height: 8.h),
              CustomTextField(controller: additionalToolsCtrl, hintText: "Additional Tools"),
              SizedBox(height: 87.h),
              /// ================================>>>>  Save and Next button    <<<<<<=============================>>>
              CustomButton(
                title: "Save and Next",
                onpress: () {
                  context.pushNamed(AppRoutes.mechanicEmploymentHistoryScreen);
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }




}

