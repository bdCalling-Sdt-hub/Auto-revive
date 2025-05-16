import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/app_routes/app_routes.dart';
import '../../../helpers/toast_message_helper.dart';
import '../../../models/booking_all_filter_model.dart';
import '../../../models/get_all_service_model.dart';
import '../../../models/job_process_complete_model.dart';
import '../../../services/api_client.dart';
import '../../../services/api_constants.dart';

class MechanicBookingAllFiltersController extends GetxController {




  RxList<BookingAllFiltersModel> bookingFilters = <BookingAllFiltersModel>[].obs;
  RxBool loading = false.obs;

  RxString filtersStatus = ''.obs;
  mechanicBookingAllFilters({String? status})async{

    if(status !=  null){
      filtersStatus.value = status;
    }

    loading(true);
    var response = await ApiClient.getData("${ApiConstants.bookingAllPaginationFilters}?page=1&limit=11&sortField=createdAt&sortOrder=desc&status=${filtersStatus??""}");

    if(response.statusCode == 200){

      bookingFilters.value = List<BookingAllFiltersModel>.from(response.body["data"].map((x)=> BookingAllFiltersModel.fromJson(x)));

      loading(false);
    }loading(false);
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




  // ================================> Mechanic Service  ==============================>

  RxBool getAllServiceLoading = false.obs;
  RxList<GetAllServiceModel> allService = <GetAllServiceModel>[].obs;
  getAllService()async{
    getAllServiceLoading(true);
    var response = await ApiClient.getData(ApiConstants.getAllServiceEndPoint);
    if(response.statusCode == 200){
      allService.value = List<GetAllServiceModel>.from(response.body["data"].map((x)=> GetAllServiceModel.fromJson(x)));
      getAllServiceLoading(false);
    }else{
      getAllServiceLoading(false);
    }
  }


// ================================> Add Service  ==============================>

  var addServiceLoading = false.obs;
  final List<Map<String, dynamic>> servicesBody = [];

  Future<void> addServiceProvider({
    required BuildContext context,
    required String serviceId
  }) async {

    print("=================================================================>>>  $servicesBody");


    addServiceLoading(true);

    try {
      var response = await ApiClient.postData(
        ApiConstants.addServiceProvider(serviceId!),
        jsonEncode(servicesBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.showToastMessage("${response.body["message"]}");
        context.pushNamed(AppRoutes.mechanicCompleteDetailsScreen, extra: {"id":"$serviceId"});

      } else {
        ToastMessageHelper.showToastMessage("Job process not found");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Failed to add service");
    } finally {
      addServiceLoading(false);
    }
  }


  /// ====================================================> Job process Complete ==================================================>


  RxBool getJobProcessCompleteLoading = false.obs;
  Rx<JobProcessCompleteModel> jobProcessComplete = JobProcessCompleteModel().obs;
  getJobProcessComplete({required String jobProcessId}) async {
    getJobProcessCompleteLoading(true);
    var response = await ApiClient.getData(ApiConstants.jobProcessCompleteProvider(jobProcessId.toString()));
    if (response.statusCode == 200) {
      jobProcessComplete.value = JobProcessCompleteModel.fromJson(response.body['data']);
      getJobProcessCompleteLoading(false);
    } else if (response.statusCode == 404) {
      getJobProcessCompleteLoading(false);
    }
  }




}