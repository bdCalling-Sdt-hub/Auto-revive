import 'package:autorevive/controllers/customer/customer_home_controller.dart';
import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/helpers/toast_message_helper.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_popup_menu.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CustomerSelectCarScreen extends StatefulWidget {
  const CustomerSelectCarScreen({super.key});

  @override
  State<CustomerSelectCarScreen> createState() =>
      _CustomerSelectCarScreenState();
}

class _CustomerSelectCarScreenState extends State<CustomerSelectCarScreen> {

  CustomerHomeController customerHomeController = Get.find<CustomerHomeController>();


  @override
  void initState() {
    customerHomeController.fetchCarModel();
    super.initState();
  }

  String selectedType = 'Sedan';
  TextEditingController carCtrl = TextEditingController();
  TextEditingController carSelectIdCtrl = TextEditingController();
  TextEditingController timeCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();



  @override
  Widget build(BuildContext context) {
    Map routerData = GoRouterState.of(context).extra as Map;
    return Scaffold(
      appBar: CustomAppBar(title: routerData["title"]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [



            routerData["title"] == "Tow Truck" ?
            Column(
              children: [

                Row(
                  children: [
                    Assets.icons.arrowLongDown.svg(),

                    SizedBox(width: 8.w),

                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.primaryShade300),
                                color: const Color(0xffE6E6FF)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 10.h),
                              child: Row(
                                children: [
                                  SizedBox(width: 8.w),
                                  const Icon(Icons.location_on, color: AppColors.primaryShade300),
                      
                                  CustomText(text: "New York, USA", color: AppColors.primaryShade300, left: 8.w),
                                ],
                              ),
                            ),
                          ),
                      
                      
                      
                      
                          SizedBox(height: 16.h),
                      
                      
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.primaryShade300),
                                color: const Color(0xffE6E6FF)
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 10.h),
                              child: Row(
                                children: [
                                  SizedBox(width: 8.w),
                                  const Icon(Icons.location_on, color: AppColors.primaryShade300),
                      
                                  CustomText(text: "California, USA", color: AppColors.primaryShade300, left: 8.w),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 20.h),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.primaryColor
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(50.r),
                    child: Column(

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 12.h,
                              width: 12.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                              ),
                            ),


                            CustomText(text: "New York, USA", color: Colors.white, left: 4.w)
                          ],
                        ),

                        Assets.icons.arrowLongDown.svg(height: 20.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 12.h,
                              width: 12.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ),
                            ),


                            CustomText(text: "California, USA", color: Colors.white, left: 4.w)
                          ],
                        ),




                        CustomText(text: "Total Distance: 23 KM", color: Colors.white, fontsize: 16.h, top: 10.h)
                      ],
                    ),
                  ),
                )

              ],
            )

           : Column(
              children: [
                CustomText(text: "Select Your Car Type...", color: Colors.black),
                SizedBox(height: 10.h),

                CustomTextField(
                  readOnly: true,
                  hintText: "Select car",
                  controller: carCtrl,
                  suffixIcon: CustomPopupMenu(
                      items: customerHomeController.carModels,
                      onSelected: (p0) {
                        carSelectIdCtrl.text = p0;
                       final selectCarThis = customerHomeController.carModels.firstWhere((x) => x.id == p0);
                        carCtrl.text = selectCarThis.name!;
                        setState(() {});
                      }),
                ),



                if(routerData["title"] != "On Site")
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

              ],
            ),






            const Spacer(),
            CustomButton(
                title: "Submit",
                onpress: () {

                  if(carSelectIdCtrl.text != ""){
                    context.pushNamed(AppRoutes.customerMapScreen, extra: {"title" : routerData["title"], "carModelId" : carSelectIdCtrl.text});

                  }else{
                    ToastMessageHelper.showToastMessage("Please select your car model!");
                  }

                  // customerHomeController.selectCarModel(selectedType.toString(), context: context, routeData: routerData["title"]);

                }),
            SizedBox(height: 50.h)


          ],
        ),
      ),
    );
  }

}
