import 'dart:convert';

import 'package:autorevive/models/get_all_experience_model.dart';
import 'package:autorevive/models/get_tools_model.dart';
import 'package:get/get.dart';
import '../../services/api_client.dart';
import '../core/app_constants/app_constants.dart';
import '../helpers/prefs_helper.dart';
import '../services/api_constants.dart';

class MechanicController extends GetxController{


  /// ================================> Get All Experienced ==============================>

  RxBool experienceLoading = false.obs;
  RxList<GetAllExperienceModel> experience = <GetAllExperienceModel>[].obs;
  getAllExperience()async{
    experienceLoading(true);
    var response = await ApiClient.getData(ApiConstants.getAllExperienceEndPoint);
    if(response.statusCode == 200){
      experience.value = List<GetAllExperienceModel>.from(response.body["data"].map((x)=> GetAllExperienceModel.fromJson(x)));
      experienceLoading(false);
    }else{
      experienceLoading(false);
    }
  }



  /// ================================> Get All Tools ==============================>

  RxBool toolsLoading = false.obs;
  RxList<GetAllToolsModel> tools = <GetAllToolsModel>[].obs;
  getAllTools()async{
    toolsLoading(true);
    var response = await ApiClient.getData(ApiConstants.getAllToolsEndPoint);
    if(response.statusCode == 200){
      tools.value = List<GetAllToolsModel>.from(response.body["data"].map((x)=> GetAllToolsModel.fromJson(x)));
      toolsLoading(false);
    }else{
      toolsLoading(false);
    }
  }










}