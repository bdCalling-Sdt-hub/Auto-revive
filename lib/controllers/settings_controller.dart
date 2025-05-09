
import 'package:autorevive/models/admin_support_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class SettingsController extends GetxController{

  /// ================================> Privacy Policy  ==============================>

  RxBool getPrivacyPolicyLoading = false.obs;
  RxString value = "".obs;
  privacyPolicy({String? name}) async {
    getPrivacyPolicyLoading(true);
    var response = await ApiClient.getData('${ApiConstants.privacyPolicy}/$name');
    if (response.statusCode == 200) {
      value.value = response.body['data']['value'];
      getPrivacyPolicyLoading(false);
    } else if (response.statusCode == 404) {
      getPrivacyPolicyLoading(false);
    }
  }

  /// ================================> Admin Support  ==============================>


  RxBool adminSupportLoading = false.obs;
  Rx<AdminSupportModel> adminSupport = AdminSupportModel().obs;
  settingAdminSupport() async {
    adminSupportLoading(true);
    var response = await ApiClient.getData(ApiConstants.adminSupport);
    if (response.statusCode == 200) {
      adminSupport.value = AdminSupportModel.fromJson(response.body['data']);
      adminSupportLoading(false);
    } else if (response.statusCode == 404) {
      adminSupportLoading(false);
    }
  }




}