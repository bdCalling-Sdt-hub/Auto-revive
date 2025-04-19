import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_popup_menu.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomerSelectCarScreen extends StatefulWidget {
  @override
  State<CustomerSelectCarScreen> createState() =>
      _CustomerSelectCarScreenState();
}

class _CustomerSelectCarScreenState extends State<CustomerSelectCarScreen> {
  final List<String> carTypes = [
    'Sedan',
    'Car',
    'SUV',
    'Truck',
    'Semi Truck',
    'Semi Trailer',
    'Pull Trailer',
    'RV',
    'Heavy Equipment',
    'Other',
  ];

  String selectedType = 'Sedan';
  TextEditingController carCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("On-site")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            CustomText(text: "Select YOur Car Type...", color: Colors.black),
            SizedBox(height: 10.h),
            CustomTextField(
              readOnly: true,
              hintText: "Select car",
              controller: carCtrl,
              suffixIcon: CustomPopupMenu(
                  items: carTypes,
                  onSelected: (p0) {
                    carCtrl.text = p0;
                    setState(() {});
                  }),
            ),
            const Spacer(),
            CustomButton(
                title: "Submit",
                onpress: () {
                  context.pushNamed(AppRoutes.customerMapScreen);
                }),
            SizedBox(height: 50.h)
          ],
        ),
      ),
    );
  }
}
