import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_image_avatar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_scaffold.dart';
import 'package:autorevive/pregentaitions/widgets/custom_slider.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../controllers/mechanic_controller/mechanic_job_controller.dart';
import '../../../../../services/api_constants.dart';
import '../../../../widgets/cachanetwork_image.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_loader.dart';
import '../../../../widgets/no_data_found_card.dart';

class TowTruckJobRequestScreen extends StatefulWidget {
  final String radius;
   TowTruckJobRequestScreen({super.key,required this.radius});

  @override
  State<TowTruckJobRequestScreen> createState() => _TowTruckJobRequestScreenState();
}

class _TowTruckJobRequestScreenState extends State<TowTruckJobRequestScreen> {


  MechanicJobController mechanicJobController = Get.put(MechanicJobController());

  @override
  void initState() {
    super.initState();
    mechanicJobController.mechanicJobAllProvider(radius: widget.radius);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await mechanicJobController.settingRadiusLimits();
      final parsed = double.tryParse(widget.radius) ?? 0;
      _miles.value = parsed;
    });
  }

  final RxDouble _miles = 0.0.obs;

  @override
  void dispose() {
    mechanicJobController.jobProvider.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final radiusLimits = mechanicJobController.radiusLimits.value.value;
    final double min = radiusLimits?.min?.toDouble() ?? 0;
    final double max = radiusLimits?.max?.toDouble() ?? 100;
    return CustomScaffold(
      appBar: AppBar(
        actions: [
          Builder(
              builder: (context) {
                return GestureDetector(
                    onTap: (){
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Assets.icons.menu.svg());
              }
          ),

          SizedBox(width: 24.w)
        ],
          centerTitle: true,
          title: CustomText(
            maxline: 2,
            text: "Job",
            fontsize: 20.sp,
          )),


      endDrawer: Drawer(
        backgroundColor: AppColors.bgColorWhite,
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.fromLTRB(16.w,60.h,16.w,8.h),
            child: Column(
              children: [
                CustomText(text: 'Filter',color: AppColors.primaryColor,fontsize: 22.sp,),
                Align(
                  alignment: Alignment.centerLeft,
                    child: CustomText(text: 'Miles From Me',fontsize: 20.sp,left: 16.w,top: 16.h,)),

                Obx(() => CustomSlider(
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.switchColor,
                  thumbColor: Colors.grey.shade300,
                  value: _miles.value,
                  min: min,
                  max: max,
                  onChanged: (val) => _miles.value = val,
                )),
                CustomText(
                  text: 'Maximum: ${max.toInt()}',
                  fontsize: 12.sp,
                  bottom: 4.h,
                ),
                Obx(() => CustomContainer(
                  alignment: Alignment.center,
                  radiusAll: 12.r,
                  width: 95.w,
                  height: 42.h,
                  bordersColor: AppColors.primaryShade300,
                  child: CustomText(
                    text: _miles.value.toInt().toString(),
                    color: Colors.black,
                    fontsize: 16.sp,
                  ),
                )),


                // CustomContainer(
                //   alignment: Alignment.center,
                //   radiusAll: 12.r,
                //   width: 95.w,
                //   height: 42.h,
                //   bordersColor: AppColors.primaryShade300,
                //   child: CustomText(
                //     text: _miles.toInt().toString(),
                //     fontsize: 16.sp,
                //   ),
                // ),
          
          


                const Spacer(),
                CustomButton(
                  title: 'Apply',
                  onpress: () {
                    Navigator.of(context).pop();
                    mechanicJobController.mechanicJobAllProvider(
                      radius: _miles.value.toInt().toString(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      body: Obx(() =>
       mechanicJobController.loading.value ?  const CustomLoader() : mechanicJobController.jobProvider.isEmpty ?  const Center(child: NoDataFoundCard()) :
          ListView.builder(
            itemCount: mechanicJobController.jobProvider.length,
            itemBuilder: (context, index) {

              var job = mechanicJobController.jobProvider[index];
              return CustomContainer(
                marginAll: 8.h,
                paddingAll: 8.h,
                color: AppColors.bgColorWhite,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(0, 3),
                      blurRadius: 3)
                ],
                bordersColor: AppColors.borderColor,
                radiusAll: 16.r,
                paddingLeft: 8.r,
                child: Row(
                  children: [
                    CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl: "${ApiConstants.imageBaseUrl}/${job.customerId?.profileImage ?? 'N/A'}",
                      height: 60.h,
                      width: 60.w,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          CustomText(
                            text: job.customerId?.name ?? 'N/A',
                            fontsize: 16.sp,
                            color: AppColors.textColor151515,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.directions_car_filled,
                                size: 14.r,
                                color: Colors.blue.shade600,
                              ),
                              SizedBox(width: 4.w),
                              Row(
                                children: [
                                  CustomText(
                                    text: job.carModelId?.name ?? 'N/A',
                                    fontsize: 10.sp,
                                    color: AppColors.pdfButtonColor,
                                  ),
                                  SizedBox(width: 5.w),
                                  CustomText(
                                      text: 'Distance: 23 KM', color: AppColors.primaryColor),

                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Obx(() {
                            bool isRequested = mechanicJobController.requestedJobIds.contains(job.id);
                            return GestureDetector(
                              onTap: () {
                                if (!isRequested) {
                                  mechanicJobController.requestId(
                                    jobId: job.id,
                                    context: context,
                                  );
                                }
                              },
                              child: CustomContainer(
                                alignment: Alignment.center,
                                width: 188.w,
                                height: 34.h,
                                color: isRequested ? Colors.grey : AppColors.primaryColor,
                                radiusAll: 100.r,
                                child: CustomText(
                                  text: isRequested ? 'Requested' : 'Request',
                                  fontsize: 10.sp,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )
      ),
    );
  }

  // Widget _buildJobCard() {
  //   return CustomContainer(
  //         marginAll: 8.h,
  //         color: AppColors.bgColorWhite,
  //     boxShadow: [
  //       BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           offset: const Offset(0, 2),
  //           blurRadius: 13)
  //     ],
  //         bordersColor: AppColors.borderColor,
  //     radiusAll: 16.r,
  //     paddingAll: 10.r,
  //     child: Row(
  //       children: [
  //          CustomImageAvatar(image: '',radius: 38.r,),
  //         SizedBox(width: 16.w),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               CustomText(text: 'David Bryan',fontsize: 16.sp,),
  //               RichText(
  //                 text: TextSpan(
  //                   style: TextStyle(fontSize: 10.sp,color: AppColors.pdfButtonColor,height: 1.6),
  //                   children: [
  //                     WidgetSpan(
  //                       child: Icon(Icons.directions_car_filled, size: 14.r,color: AppColors.pdfButtonColor,),
  //                     ),
  //                     const TextSpan(
  //                       text: ' Sedan \n Distance: 23 KM',
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: 10.h),
  //               CustomContainer(
  //                 alignment: Alignment.center,
  //                 width: 188.w,
  //                 height: 28.h,
  //                 color: AppColors.primaryColor,
  //                 radiusAll: 100.r,
  //                 child: CustomText(
  //                   text: 'Request',
  //                   fontsize: 10.sp,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }



}
