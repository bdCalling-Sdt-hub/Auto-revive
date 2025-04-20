import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_checkbox_list.dart';
import 'package:autorevive/pregentaitions/widgets/custom_linear_indicator.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/custom_upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BusinessRequirementScreen extends StatefulWidget {
  const BusinessRequirementScreen({super.key});

  @override
  State<BusinessRequirementScreen> createState() => _BusinessRequirementScreenState();
}

class _BusinessRequirementScreenState extends State<BusinessRequirementScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _dateTEController = TextEditingController();

  final Map<String, bool> _services = {
    'Maintain active DOT registration & insurance coverage at all times.': false,
    'Adhere to all local, state, and federal regulations for towing operations.': false,
    'Provide timely and professional service for Fix It LLC customers.': false,
    'Maintain clean and well-maintained tow trucks and equipment.': false,
    'Communicate accurate ETAs and service updates.': false,
    'Submit a live walk-around video showing that all trucks meet operational standards.': false,
    'I certify that the information provided is accurate and that my company meets all requirements for partnering with Fix It LLC.': false,
  };


  void _getSelectedItems() {
    final selected = _services.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    print("Selected Services: $selected");
  }

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

                onTap: (){}),

            CustomTextField(
              readOnly: true,
              onTap: _selectDate,
              controller: _dateTEController,
              labelText: 'Date',
              hintText: 'Date',
              suffixIcon: const Icon(Icons.date_range_outlined),
            ),

            SizedBox(height: 44.h),
            Center(
                child: CustomButton(
                    title: 'Submit',
                    onpress: () {
                      context.pushNamed(AppRoutes.profileDetailsScreen);
                    })),
            SizedBox(height: 24.h),
          ],
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
        _dateTEController.text = formattedDate;
      });
    }
  }

}
