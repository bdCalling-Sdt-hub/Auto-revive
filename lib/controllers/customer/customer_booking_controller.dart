
import 'dart:io';

import 'package:autorevive/helpers/toast_message_helper.dart';
import 'package:get/get.dart';

import '../../models/customer_booking_model.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class CustomerBookingController extends GetxController {


  RxList<CustomerBookingModel> booking = <CustomerBookingModel>[].obs;
  RxBool bookingLoading = false.obs;
  RxString bookingStatus = ''.obs;
  fetchBooking({String? status, String? nextStatus}) async {
    if (status != null) {
      bookingStatus.value = status;
    }
    bookingLoading(true);
    var response = await ApiClient.getData(
        "${ApiConstants.customerBookingEndPoint}?page=1&limit=11&sortField=createdAt&sortOrder=desc&status=${bookingStatus ?? ""}&nextStatus=${nextStatus?? ""}");

    if (response.statusCode == 200) {
      booking.value = List<CustomerBookingModel>.from(
          response.body["data"].map((x) => CustomerBookingModel.fromJson(x)));

      bookingLoading(false);
    }
    bookingLoading(false);
  }




  ///====================Post Job =====================>>>

  RxBool customerInitPaymentLoading = false.obs;
 Future<String?> customerInitBooking({String? status, String? id, bool? isToast}) async {
    customerInitPaymentLoading(true);
    var body = {
      "status": "$status"
    };
    var response = await ApiClient.putData(ApiConstants.initBookingCustomer+"/${id?? ""}", body);
    if (response.statusCode == 200 || response.statusCode == 201) {
     booking.removeWhere((x) => x.id == id);

     if(isToast??true){
       ToastMessageHelper.showToastMessage("${response.body["message"]}");
     }


      update();

      customerInitPaymentLoading(false);
     return "completed";
    }

    customerInitPaymentLoading(false);
    return "fail";
  }




  RxList<ServicesModelCustomer> services = <ServicesModelCustomer>[].obs;
  RxBool servicesLoading = false.obs;
  RxString? totalPrice = ''.obs;
  getService({String? id})async{
    servicesLoading(true);
    var response = await ApiClient.getData("${ApiConstants.getCustomerServices}/${id??""}");

    if (response.statusCode == 200) {
      services.value = List<ServicesModelCustomer>.from(response.body["data"]["services"].map((x) => ServicesModelCustomer.fromJson(x)));

      totalPrice?.value = response.body["data"]["servicePrice"].toString();

      print("======================services : ${services}");

      servicesLoading(false);
    }
    servicesLoading(false);
  }




  RxBool cancelPaymentLoading = false.obs;
  cancelPayment({required List<File> images ,String? jobId, String? type, String? refundDetails}) async {
    cancelPaymentLoading(true);

    List<MultipartBody> photoList = [];
    for(var photos in images){
      photoList.add(MultipartBody("files", photos));
    }
    List<MultipartBody> multipartBody = photoList ?? [];

    var body = {
      "jobProcessId": "$jobId",
      "type": "$type",
      "refundDetails": "$refundDetails"
    };
    var response = await ApiClient.postMultipartData(ApiConstants.paymentRefundRequest, body, multipartBody: multipartBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
      booking.removeWhere((x) => x.id == jobId);
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      update();
      cancelPaymentLoading(false);
    }
    cancelPaymentLoading(false);
  }



}




class ServicesModelCustomer {
  final int? amount;
  final String? service;

  ServicesModelCustomer({
    this.amount,
    this.service,
  });

  factory ServicesModelCustomer.fromJson(Map<String, dynamic> json) => ServicesModelCustomer(
    amount: json["amount"],
    service: json["service"],
  );
}
