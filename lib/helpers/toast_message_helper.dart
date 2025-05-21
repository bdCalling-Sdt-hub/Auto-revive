import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../core/constants/app_colors.dart';


class ToastMessageHelper{
 static void showToastMessage(String message, {bool isSuccess =  true}) {
    // Fluttertoast.showToast(
    //   msg: message,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.TOP,
    //   timeInSecForIosWeb: secound ?? 2,
    //   backgroundColor: AppColors.primaryColor,
    //   textColor: Colors.white,
    //   fontSize: 16.h,
    // );


   toastification.show(
     type: ToastificationType.success,
     style: ToastificationStyle.flatColored,
     autoCloseDuration: const Duration(seconds: 3),
     title:  Text(isSuccess ? 'Success' : "Fail", style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
     description: RichText(text:  TextSpan(text: message.toString(), style: const TextStyle(color: Colors.black))),
     alignment: Alignment.topRight,
     direction: TextDirection.ltr,
     animationDuration: const Duration(milliseconds: 300),
     animationBuilder: (context, animation, alignment, child) {
       return FadeTransition(
         opacity: animation,
         child: child,
       );
     },
     icon: const Icon(Icons.check),
     showIcon: true, // show or hide the icon
     primaryColor: AppColors.primaryColor,
     backgroundColor: Colors.white,
     foregroundColor: Colors.black,
     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
     margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
     borderRadius: BorderRadius.circular(12),
     boxShadow: const [
       BoxShadow(
         color: Color(0x07000000),
         blurRadius: 16,
         offset: Offset(0, 16),
         spreadRadius: 0,
       )
     ],
     showProgressBar: true,
     closeButton: ToastCloseButton(
       showType: CloseButtonShowType.onHover,
       buttonBuilder: (context, onClose) {
         return OutlinedButton.icon(
           onPressed: onClose,
           icon: const Icon(Icons.close, size: 20),
           label: const Text('Close'),
         );
       },
     ),
     closeOnClick: false,
     pauseOnHover: true,
     dragToClose: true,
     applyBlurEffect: true,
     callbacks: ToastificationCallbacks(
       onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
       onCloseButtonTap: (toastItem) => print('Toast ${toastItem.id} close button tapped'),
       onAutoCompleteCompleted: (toastItem) => print('Toast ${toastItem.id} auto complete completed'),
       onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
     ),
   );
  }
}