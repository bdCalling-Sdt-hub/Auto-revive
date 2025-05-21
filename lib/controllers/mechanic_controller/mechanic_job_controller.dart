import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../services/api_client.dart';
import '../../../../../services/api_constants.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/all_job_provider_model.dart';
import '../../models/redius_limits_model.dart';

class MechanicJobController extends GetxController {

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
  RxList<AllJobProviderModel> jobProvider = <AllJobProviderModel>[].obs;
  mechanicJobAllProvider({required String radius}) async {
    if(page.value == 1){
      loading(true);
    }
    loading.value = true;
    var response = await ApiClient.getData(ApiConstants.getAllJobProvider("${page.value}",radius));
    if (response.statusCode == 200) {
      totalPages = jsonDecode(response.body['pagination']['totalPages'].toString()) ?? 0;
      currentPage = jsonDecode(response.body['pagination']['currentPage'].toString()) ?? 0;
      total = jsonDecode(response.body['pagination']['total'].toString()) ?? 0;


      var data = List<AllJobProviderModel>.from(response.body['data'].map((x) => AllJobProviderModel.fromJson(x)));
      jobProvider.addAll(data);
      update();
      loading(false);
    } else {
      loading.value = false;
    }
  }



  /// ===========================================> Radius Limits ==================================>

  RxBool radiusLimitsLoading = false.obs;
  Rx<RadiusLimitsModel> radiusLimits = RadiusLimitsModel().obs;
  settingRadiusLimits() async {
    radiusLimitsLoading(true);
    var response = await ApiClient.getData(ApiConstants.radiusLimits);
    if (response.statusCode == 200) {
      radiusLimits.value = RadiusLimitsModel.fromJson(response.body['data']);
      radiusLimitsLoading(false);
    } else if (response.statusCode == 404) {
      radiusLimitsLoading(false);
    }
  }



/// ===========================================> Job Request ==================================>


  var jobIdLoading = false.obs;
  var requestedJobIds = <String>[].obs;

  Future<void> requestId({
    String? jobId,
    required BuildContext context,
  }) async {
    var body = {
      'jobId': jobId,
    };

    jobIdLoading(true);

    try {
      var response = await ApiClient.postData(
        ApiConstants.jobRequest,
        jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.showToastMessage("${response.body["message"]}");

        if (jobId != null && !requestedJobIds.contains(jobId)) {
          requestedJobIds.add(jobId);
        }

      } else {
        ToastMessageHelper.showToastMessage("Please try again later or choose a different job");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Failed to job request");
    } finally {
      jobIdLoading(false);
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
