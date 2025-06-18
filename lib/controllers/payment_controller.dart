import 'dart:convert';
import 'package:autorevive/core/app_constants/app_constants.dart';
import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/helpers/prefs_helper.dart';
import 'package:autorevive/pregentaitions/widgets/custom_button.dart';
import 'package:autorevive/services/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../models/payment_history_model.dart';
import '../services/api_client.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../services/vibration_service.dart';

class PaymentController extends GetxController{


  Map<String, dynamic>? paymentIntentData;

  requestToAddBalance({required String price,required BuildContext context})async{
    Map<String, dynamic> body = {
      "amount": int.parse(price.toString()),
    };


    final apiResponse = await ApiClient.postData(ApiConstants.addBalance, jsonEncode(body));

    if (apiResponse.statusCode==200|| apiResponse.statusCode==201) {

      var url = apiResponse.body["data"];
      context.pushNamed(AppRoutes.paymentWebView, extra: url);

      if (kDebugMode) {
        debugPrint("Payment successfully created: ${apiResponse.body}");
      }
    }
  }


/// ===================================> Withdraw Request ==============================>

  RxBool withDrawLoading = false.obs;
  withdrawRequestBalance({required String price,required BuildContext context})async{
    withDrawLoading(true);
    Map<String, dynamic> body = {
      "amount": int.parse(price.toString()),
    };


    final apiResponse = await ApiClient.postData(ApiConstants.withdrawRequest, jsonEncode(body));

    if (apiResponse.statusCode==200|| apiResponse.statusCode==201) {

      var url = apiResponse.body["data"]["url"];
      context.pushNamed(AppRoutes.paymentWebView, extra: url);

      if (kDebugMode) {
        debugPrint("=============================================Payment successfully created: ${apiResponse.body}");
      }
      withDrawLoading(false);
    }else{
      withDrawLoading(false);
    }
  }



  // RxBool paymentLoading = false.obs;
  //
  // withdrawRequestBalance({required String price,required BuildContext context}) async {
  //
  //   paymentLoading(true);
  //
  //
  //   Map<String, dynamic> body = {
  //     "amount": int.parse(price.toString()),
  //   };
  //   // Map<String, String> body = {
  //   //   "amount": int.parse(price.toString()),
  //   // };
  //
  //   var response = await ApiClient.postData(
  //       ApiConstants.withdrawRequest,
  //       jsonEncode(body)
  //   );
  //
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     launchUrl(Uri.parse(response.body["data"]["url"]), mode: LaunchMode.externalApplication);
  //     print("================================================>${response.body["data"]["url"]}");
  //     paymentLoading(false);
  //   } else if(response.statusCode == 1){
  //     paymentLoading(false);
  //     ToastMessageHelper.showToastMessage("Server error! \n Please try later");
  //   } else {
  //     paymentLoading(false);
  //     ToastMessageHelper.showToastMessage(response.body["message"]);
  //   }
  // }








  /// ================================> Payment History  ==============================>

  RxBool paymentHistoryLoading = false.obs;
  Rx<PaymentHistoryModel> paymentHistory = PaymentHistoryModel().obs;
  getPaymentHistory()async{
    paymentHistoryLoading(true);
    var response = await ApiClient.getData(ApiConstants.paymentHistory);
    if(response.statusCode == 200){
      paymentHistory.value = PaymentHistoryModel.fromJson(response.body['data']);
      paymentHistoryLoading(false);
    }else{
      paymentHistoryLoading(false);
    }
  }



  final isLoading = false.obs;
  /// Handles the final payment result
  Future<void> paymentResults({required String finishUrl,required BuildContext context}) async {
    try {
      isLoading(true);

      var accessToken = await PrefsHelper.getString(AppConstants.bearerToken);
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse(finishUrl), headers: headers);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody != null && responseBody["message"] == "Payment successfully.") {


          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentSuccessScreen(title: "Payment Success", message: "Payment was successful!")));

        } else {


          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentSuccessScreen(title: "Payment Fail", message: "Payment was Fail! Please Try again")));


        }
      } else {

        // QuickAlert.show(
        //   context: context,
        //   type: QuickAlertType.error,
        //   text: "Your transaction failed. Please try again.",
        //   onConfirmBtnTap: () {
        //     context.pushNamed(AppRoutes.customerBottomNavBar);
        //   },
        // );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }


}




class PaymentSuccessScreen extends StatefulWidget {
  final String title;
  final String message;
   PaymentSuccessScreen({super.key, required this.title, required this.message});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {


  @override
  void initState() {
    vibration();
    super.initState();
  }

  vibration()async{
    VibrationService.vibrateForDuration(1500);
    await Future.delayed(Duration(milliseconds: 1000));
    VibrationService.vibrateForDuration(1500);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('${widget.title}'),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.r),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Lottie animation

              SizedBox(height: 100.h),

              widget.title == "Payment Success" ?
              Assets.lottie.paymentsuccess.lottie(height: 150.h) : Assets.lottie.paymentfail.lottie(height: 150.h) ,

               SizedBox(height: 24.h),

              // Success message
               Text('${widget.message}',
                style: TextStyle(
                  fontSize: 20.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
               SizedBox(height: 24.h),


              Spacer(),

              CustomButton(title: "Go To Home", onpress: () {
                context.go(AppRoutes.customerBottomNavBar);
              }),

              SizedBox(height: 50.h)
            ],
          ),
        ),
      ),
    );
  }
}
