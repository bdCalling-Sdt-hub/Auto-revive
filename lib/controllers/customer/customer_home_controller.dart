import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_routes/app_routes.dart';
import '../../models/car_model.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class CustomerHomeController extends GetxController {
  ///===============Select Car Model================<>

  RxBool carModelLoading = false.obs;

  selectCarModel(String model, {required BuildContext context, String routeData = ''}) async {
    carModelLoading(true);
    var body = {"name": "$model"};

    var response =
        await ApiClient.postData(ApiConstants.carModel, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {


      carModelLoading(false);
    }
    carModelLoading(false);
  }
  
  

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
  
}
