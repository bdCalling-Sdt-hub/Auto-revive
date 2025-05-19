import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/helpers/toast_message_helper.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../controllers/mechanic_controller/mechanic_on_site_controller/booking_all_filters_controller.dart';
import '../../../../../core/config/app_routes/app_routes.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_loader.dart';

class MechanicBookingsDetailsScreen extends StatefulWidget {
  const MechanicBookingsDetailsScreen({super.key});
  @override
  State<MechanicBookingsDetailsScreen> createState() => _MechanicBookingsDetailsScreenState();
}

class _MechanicBookingsDetailsScreenState extends State<MechanicBookingsDetailsScreen> {

  MechanicBookingAllFiltersController mechanicBookingAllFiltersController = Get.put(MechanicBookingAllFiltersController());

  @override
  void initState() {
    super.initState();
    mechanicBookingAllFiltersController.getAllService();
  }

  @override
  void dispose() {
    mechanicBookingAllFiltersController.servicesBody.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map routeData = GoRouterState.of(context).extra as Map;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          title: "${routeData["title"]}"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.w),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomImageAvatar(image: "${routeData["image"]}", radius: 44.r),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "${routeData["name"]}",
                            fontsize: 20.sp,
                            bottom: 6.h,
                          ),
                          CustomText(
                            text: (routeData["address"] == null || routeData["address"].toString().isEmpty)
                                ? 'N/A'
                                : routeData["address"].toString(),
                            fontsize: 20.sp,
                            bottom: 6.h,
                          ),

                          // CustomText(
                          //   text: "${routeData["address"]}",
                          //   fontsize: 20.sp,
                          //   bottom: 6.h,
                          // ),
                        ],
                      ),
                      SizedBox(height: 10.w),
                      Row(
                        children: [
                          Assets.icons.detailsMessage.svg(),
                          SizedBox(width: 6.w),
                          GestureDetector
                            (
                            onTap: () {
                              context.pushNamed(AppRoutes.mechanicMapScreen);
                            },
                              child: Assets.icons.detailsLocation.svg()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 26.h),
            // ============>> Service Search and Selection <<============= //
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    fontsize: 20.sp,
                    color: AppColors.textColor151515,
                    text: 'Problem(s) need to be solved',
                  ),
                  SizedBox(height: 18.h),
                  // Search Box
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Service Name',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.search, color: AppColors.primaryShade300),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// =====================================> Scrollable Services List ======================================>
                  Obx((){
                    if (mechanicBookingAllFiltersController.getAllServiceLoading.value) {
                      return  const Center(child: CustomLoader());
                    }

                    if (mechanicBookingAllFiltersController.allService.isEmpty) {
                      return const Center(
                        child: Text(
                          'No data available',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       height: 330.h,
                       padding: EdgeInsets.all(8.w),
                       decoration: BoxDecoration(
                         border: Border.all(color: AppColors.primaryShade300),
                         borderRadius: BorderRadius.circular(8.r),
                       ),
                       child: Scrollbar(
                         thickness: 4,
                         radius: Radius.circular(8.r),
                         child: ListView.builder(
                           itemCount: mechanicBookingAllFiltersController.allService.length,
                           itemBuilder: (context, index) {
                             final service = mechanicBookingAllFiltersController.allService[index];
                             const bool isEnabled = true;
                             final TextEditingController priceController = TextEditingController();
                              RxBool checked = false.obs;
                             return Column(
                               children: [
                                 Padding(
                                   padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 8),
                                   child: ListTile(
                                     dense: true,
                                     contentPadding: EdgeInsets.zero,
                                     leading: Theme(
                                       data: Theme.of(context).copyWith(
                                         unselectedWidgetColor: Colors.blue,
                                       ),
                                       child: Obx(() {
                                         return Checkbox(
                                           value: checked.value,
                                           onChanged: isEnabled ? (v) {} : null,
                                           activeColor: AppColors.primaryColor,
                                           checkColor: Colors.white,
                                           side: const BorderSide(
                                             color: AppColors.primaryColor,
                                             width: 2,
                                           ),
                                         );
                                       })
                                     ),
                                     title: Text(
                                       service.name.toString(),
                                       style:  TextStyle(
                                         fontSize: 12.sp,
                                         color: isEnabled ? Colors.black : Colors.grey,
                                         decoration: isEnabled ? null : TextDecoration.lineThrough,
                                       ),
                                     ),
                                     trailing: Container(
                                       width: 50.w,
                                       padding: EdgeInsets.symmetric(horizontal: 6.w),
                                       decoration: BoxDecoration(
                                         color: checked.value ? Colors.grey.shade200 : Colors.white, // white if unchecked
                                         borderRadius: BorderRadius.circular(6.r),
                                         border: Border.all(color: AppColors.primaryShade300),
                                       ),
                                       child:

                                       TextField(
                                         controller: priceController,
                                         keyboardType: TextInputType.number,
                                         style: TextStyle(fontSize: 14.sp),
                                         decoration: const InputDecoration(
                                           border: InputBorder.none,
                                           hintText: "\$",
                                           isDense: true,
                                           contentPadding: EdgeInsets.symmetric(vertical: 2),
                                         ),
                                         enabled: isEnabled,
                                         onChanged: (val) {

                                           print("-------------------------------  value : $val");

                                           if(val.trim().isEmpty){

                                             mechanicBookingAllFiltersController.servicesBody
                                                 .removeWhere((item) => item['serviceId'] == service.id.toString());
                                             checked(false);
                                             checked.refresh();
                                           }else{

                                             // Remove previous entry if exists (to update amount)
                                             mechanicBookingAllFiltersController.servicesBody
                                                 .removeWhere((item) => item['serviceId'] == service.id.toString());

                                             // Add updated entry
                                             mechanicBookingAllFiltersController.servicesBody.add({
                                               "serviceId": service.id.toString(),
                                               "amount": int.parse(val.trim()),
                                             });
                                             checked(true);
                                           checked.refresh();
                                           }
                                         },
                                       ),

                                     ),
                                   ),
                                 ),
                                 if (index != mechanicBookingAllFiltersController.allService.length - 1)
                                   Divider(
                                     color: AppColors.primaryShade300.withOpacity(0.5),
                                     thickness: 0.5,
                                     height: 1.h,
                                     endIndent: 0.1,
                                   ),
                               ],
                             );

                           },
                         ),
                       ),
                     ),
                   );
                  }
                  ),

                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child:
              CustomButton(
                loading: mechanicBookingAllFiltersController.addServiceLoading.value,
                  title: 'Submit',
                  onpress: () {
                if(mechanicBookingAllFiltersController.servicesBody.isEmpty){
                  ToastMessageHelper.showToastMessage("Please enter price!");
                }else{
                  mechanicBookingAllFiltersController.addServiceProvider(
                      context: context, serviceId: routeData["id"]?.toString() ?? ""
                  );
                }

              }),
            ),
            SizedBox(height: 260.h),
          ],
        ),
      ),
    );
  }





}

