import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../helpers/toast_message_helper.dart';
import '../../../models/booking_all_filter_model.dart';
import '../../../services/api_client.dart';
import '../../../services/api_constants.dart';

class MechanicBookingAllFiltersController extends GetxController {

  RxInt page = 1.obs;
  var totalPages = (-1);
  var currentPage = (-1);
  var total = (-1);
  void loadMore() {
    print("==========================================total page ${totalPages} page No: ${page.value} == total result ${total}");
    if (totalPages > page.value) {
      page.value += 1;
      print("**********************print here");
      update();
    }
    print("**********************print here**************");
  }
  RxBool loading = false.obs;
  RxList<BookingAllFiltersModel> bookingFilters = <BookingAllFiltersModel>[].obs;
  mechanicBookingAllFilters({String status = '',limit}) async {
    if(page.value == 1){
      loading(true);
    }
    loading.value = true;
    var response = await ApiClient.getData(ApiConstants.bookingAllPaginationFilters("${page.value}",status,limit));
    if (response.statusCode == 200) {
      totalPages = jsonDecode(response.body['pagination']['totalPages'].toString()) ?? 0;
      currentPage = jsonDecode(response.body['pagination']['currentPage'].toString()) ?? 0;
      total = jsonDecode(response.body['pagination']['total'].toString()) ?? 0;
      var data = List<BookingAllFiltersModel>.from(response.body['data'].map((x) => BookingAllFiltersModel.fromJson(x)));
      bookingFilters.addAll(data);
      update();
      loading(false);
    } else {
      loading.value = false;
    }
  }



  /// ===========================================> Mechanic Job Bookings Screen Status Change ==================================>

  var changeStatusLoading = false.obs;

  Future<void> changeStatus({
    String? status,
    String? jobId,
    required BuildContext context,
  }) async {
    var body = {
      'status': status,
    };

    changeStatusLoading(true);

    try {
      var response = await ApiClient.putData(
        ApiConstants.changeStatus(jobId!),
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.showToastMessage("${response.body["message"]}");

      } else {
        ToastMessageHelper.showToastMessage("Failed to change status.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong.");
    } finally {
      changeStatusLoading(false);
    }
  }





}