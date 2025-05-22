import 'package:autorevive/models/get_all_experience_model.dart';
import 'package:autorevive/models/get_tools_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../helpers/toast_message_helper.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';


class TowTrackController extends GetxController{




  /// ================================> Tow Track Basic Info ==============================>


  var basicInfoLoading = false.obs;

  Future<bool> towTrackBasicInfo({
    String? profileImage,
    String? phone,
    String? address,
    int? ppm,
    String? llc,
    required BuildContext context,
  }) async {
    var body = {
      'profileImage': profileImage,
      'phone': phone,
      'address': address,
      'ppm': ppm,
      'llc': llc,
    };

    basicInfoLoading(true);

    try {
      var response = await ApiClient.putData(
        ApiConstants.towTrackBasicInfoEndPoint,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        ToastMessageHelper.showToastMessage("${response.body["message"]}");
        return true;
      } else {
        ToastMessageHelper.showToastMessage("Select profile image!");
        return false;
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong.");
      return false;
    } finally {
      basicInfoLoading(false);
    }
  }






}