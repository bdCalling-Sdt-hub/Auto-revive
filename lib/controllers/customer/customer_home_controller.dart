import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_routes/app_routes.dart';
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
      context.pushNamed(AppRoutes.customerMapScreen, extra: {"title" : routeData});

      carModelLoading(false);
    }
    carModelLoading(false);
  }
}
