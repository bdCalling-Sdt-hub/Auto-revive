import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/CustomChecked.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_checkbox_list.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ServiceCoverageScreen extends StatefulWidget {
  const ServiceCoverageScreen({super.key});

  @override
  State<ServiceCoverageScreen> createState() => _ServiceCoverageScreenState();
}

class _ServiceCoverageScreenState extends State<ServiceCoverageScreen> {
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  final TextEditingController _regionsCoveredTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  final Map<String, bool> _services = {
    'Light-Duty Towing (Cars & Small Trucks)': false,
    'Medium-Duty Towing (Box Trucks & RVs)': false,
    'Heavy-Duty Towing (Semis & Large Trucks)': false,
    'Roadside Assistance (Jump-starts, Lockouts, Fuel Delivery).': false,
    'Winch-Out & Recovery Services': false,
    'Equipment Transport': false,
  };

  final Map<String, bool> checkboxOptions = {
    'Under 30 minutes': false,
    '30-60 minutes': false,
    'Over 1 hour': false,
  };

  void _getSelectedItems() {
    final selected = _services.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    print("Selected Services: $selected");
  }

  bool? _emergencyTowingChecked;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
          centerTitle: false,
          title: CustomText(
            text: "Service and Coverage Area..",
            fontsize: 20.sp,
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomLinearIndicator(
                progressValue: 0.8,
              ),
              SizedBox(height: 24.h),
              CustomText(
                text: 'What types of towing services do you offer',
                bottom: 6.h,
              ),
              CustomCheckboxList(
                isAllChecked: true,
                items: _services,
              ),

              SizedBox(height: 10.h),
              CustomText(
                text: 'What is your primary service area?',
                bottom: 6.h,
              ),

              ///CountryStateCityPicker Widget initialize
              CountryStateCityPicker(
                country: country,
                state: state,
                city: city,
                dialogColor: Colors.grey.shade200,
                textFieldDecoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.sp,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(16.r)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(16.r)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(16.r)),
                ),
              ),
              SizedBox(height: 16.h),

              CustomTextField(
                controller: _regionsCoveredTEController,
                labelText: 'Regions Covered..',
                hintText: 'Regions Covered..',
              ),

              CustomChecked(
                  title: 'Do you offer 24/7 emergency towing?',
                  selected: _emergencyTowingChecked,
                  onChanged: (val) {
                    _emergencyTowingChecked = val;
                    setState(() {});
                  }),

              CustomText(
                top: 8.h,
                text: 'Average ETA for service calls.',
              ),

              CustomCheckboxList(
                items: checkboxOptions,
              ),
              SizedBox(height: 44.h),
              Center(
                  child: CustomButton(
                      title: 'Save and Next',
                      onpress: () {
                        if(_globalKey.currentState!.validate()) return;
                        context.pushNamed(AppRoutes.businessRequirementScreen);
                      })),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
