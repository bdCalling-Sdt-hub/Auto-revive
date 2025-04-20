import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_popup_menu.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CustomerSelectCarScreen extends StatefulWidget {
  const CustomerSelectCarScreen({super.key});

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
  TextEditingController timeCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("On-site")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            CustomText(text: "Select Your Car Type...", color: Colors.black),
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



            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Time",
                        fontsize: 16.h,
                        bottom: 8.h,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            final now = DateTime.now();
                            final dt = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
                            final formattedTime = TimeOfDay.fromDateTime(dt).format(context);
                            timeCtrl.text = formattedTime;
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextField(
                            readOnly: true,
                            controller: timeCtrl,
                            hintText: "Select Time",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Date",
                        fontsize: 16.h,
                        color: Colors.black,
                        bottom: 8.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            final formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                            dateCtrl.text = formattedDate;
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextField(
                            readOnly: true,
                            controller: dateCtrl,
                            hintText: "Select Date",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
