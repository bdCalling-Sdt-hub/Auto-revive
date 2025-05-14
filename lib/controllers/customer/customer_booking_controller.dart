import 'package:get/get.dart';

import '../../models/customer_booking_model.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class CustomerBookingController extends GetxController{

  RxList<CustomerBookingModel> booking = <CustomerBookingModel>[].obs;
  RxBool bookingLoading = false.obs;

  RxString bookingStatus = ''.obs;
  fetchBooking({String? status})async{

    if(status !=  null){
      bookingStatus.value = status;
    }

    bookingLoading(true);
    var response = await ApiClient.getData("${ApiConstants.customerBookingEndPoint}?page=1&limit=11&sortField=createdAt&sortOrder=desc&status=${bookingStatus??""}");

    if(response.statusCode == 200){

      booking.value = List<CustomerBookingModel>.from(response.body["data"].map((x)=> CustomerBookingModel.fromJson(x)));

      bookingLoading(false);
    }bookingLoading(false);
  }





}