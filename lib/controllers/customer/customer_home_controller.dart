import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_routes/app_routes.dart';
import '../../models/car_model.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class CustomerHomeController extends GetxController {


  RxList<CarModel> carModels = <CarModel>[].obs;
  RxBool fetchCarModelLoading = false.obs;

  fetchCarModel()async{
    fetchCarModelLoading(true);
    var response = await ApiClient.getData(ApiConstants.carModel);

    if(response.statusCode == 200){

      carModels.value = List<CarModel>.from(response.body["data"].map((x)=> CarModel.fromJson(x)));

      fetchCarModelLoading(false);
    }fetchCarModelLoading(false);
  }




  ///====================Post Job =====================>>>

  RxBool postJobLoading = false.obs;
  postJob({String? carModelId, required BuildContext context, String? platForm, List<String>? targets}) async {
    postJobLoading(true);
    var body = {
      "platform": platForm?.toLowerCase().toString(),
      "targets": targets,
      "carModelId": "$carModelId"
    };
    var response = await ApiClient.postData(ApiConstants.postJob, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      postJobLoading(false);
    }
    postJobLoading(false);
  }




}
