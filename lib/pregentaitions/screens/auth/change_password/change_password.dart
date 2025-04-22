//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../../core/constants/app_colors.dart';
// import '../../../widgets/custom_text.dart';
// import '../../../widgets/custom_text_field.dart';
//
//
//
// class ChangePasswordScreen extends StatefulWidget {
//   ChangePasswordScreen({super.key});
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//
//   final TextEditingController newPasswordCTRl = TextEditingController();
//   final TextEditingController conformPasswordCTRl = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFFF0F5E9), Color(0xFFFFFFFF)],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: 17.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 20.h, vertical: 20.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // /// =====================================> Current Password ===================================>
//                     // CustomText(
//                     //   text: 'Current Password'.tr,
//                     //   fontsize: 14.sp,
//                     //   fontWeight: FontWeight.w400,
//                     //   color: AppColors.textColor333333,
//                     // ),
//                     // SizedBox(height: 11.h),
//                     // CustomTextField(
//                     //   controller: currentPasswordCTRl,
//                     //   hintText: 'Enter current password'.tr,
//                     //   prefixIcon: 'assets/icons/lock.svg',
//                     //   isObscureText: true,
//                     //   isPassword: true,
//                     //   validator: (value) {
//                     //     if (value == null || value.isEmpty) {
//                     //       return "Please enter your password";
//                     //     }
//                     //     return null;
//                     //   },
//                     //   contenpaddingHorizontal: 20.w,
//                     //   contenpaddingVertical: 18.h,
//                     // ),
//                     // SizedBox(height: 20.h),
//                     /// =====================================> New Password ===================================>
//                     CustomText(
//                       text: 'New Password',
//                       fontsize: 14.sp,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.textColor333333,
//                     ),
//                     SizedBox(height: 11.h),
//                     CustomTextField(
//                       controller: newPasswordCTRl,
//                       hintText: 'Enter new password',
//                       prefixIcon: 'assets/icons/lock.svg',
//                       isObscureText: true,
//                       isPassword: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter your password";
//                         }
//                         return null;
//                       },
//                       contenpaddingHorizontal: 20.w,
//                       contenpaddingVertical: 18.h,
//                     ),
//                     SizedBox(height: 20.h),
//                     /// =====================================> Confirm New Password ===================================>
//                     CustomText(
//                       text: 'Confirm New Password',
//                       fontsize: 14.sp,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.textColor333333,
//                     ),
//                     SizedBox(height: 11.h),
//                     CustomTextField(
//                       controller: conformPasswordCTRl,
//                       hintText: 'Enter confirm password',
//                       prefixIcon: 'assets/icons/lock.svg',
//                       isObscureText: true,
//                       isPassword: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter your password";
//                         }
//                         return null;
//                       },
//                       contenpaddingHorizontal: 20.w,
//                       contenpaddingVertical: 18.h,
//                     ),
//
//                     SizedBox(height: 200.h),
//                     CustomGradientButton(onTap: () {
//                       authController.setPassword(conformPasswordCTRl.text);
//                     }, title: 'Save'.tr),
//                     SizedBox(height: 24.h),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 27.h),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
