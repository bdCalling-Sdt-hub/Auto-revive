import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                value: selectedType,

                hint: const Icon(Icons.arrow_drop_down),
                items: carTypes.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: item != carTypes.last
                            ? const Border(
                          bottom: BorderSide(color: Colors.black12, width: 1),
                        )
                            : null,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedType = value!;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 400,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  offset: const Offset(0, -1),
                ),
                isDense: false,
                underline: const SizedBox(),

                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  // padding: EdgeInsets.only(left: 12, right: 12),
                ),
              ),
            ),




            SizedBox(height: 100,),


            CustomButton(title: "title", onpress: () {
              context.pushNamed(AppRoutes.customerMapScreen);
            },)
          ],
        ),
      ),
    );
  }
}
