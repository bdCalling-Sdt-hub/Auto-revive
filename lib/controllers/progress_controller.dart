import 'package:get/get.dart';

import '../models/progress_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class ProgressController extends GetxController{



  RxList<ProgressModel> progress = <ProgressModel>[].obs;
  RxBool progressLoading = false.obs;


  fetchProgress({String? status, String? nextStatus}) async {
    if (status != null) {
      update();
    }
    progressLoading(true);
    var response = await ApiClient.getData(
        "${ApiConstants.progress}");

    if (response.statusCode == 200) {
      progress.value = List<ProgressModel>.from(
          response.body["data"].map((x) => ProgressModel.fromJson(x)));

      progressLoading(false);
    }
    progressLoading(false);
  }



}