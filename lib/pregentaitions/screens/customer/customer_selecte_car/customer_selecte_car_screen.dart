import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("On-site")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),





            Spacer(),

            CustomButton(title: "Submit", onpress: () {
              context.pushNamed(AppRoutes.customerMapScreen);
            }),

            SizedBox(height: 50.h)
          ],
        ),
      ),
    );
  }
}
