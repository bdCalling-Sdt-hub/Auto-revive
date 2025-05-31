import 'package:autorevive/models/get_tow_track_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_routes/app_routes.dart';
import '../../helpers/toast_message_helper.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';


class TowTrackController extends GetxController{




  /// ================================> Tow Track Basic Info ==============================>


  var basicInfoLoading = false.obs;

  Future<bool> towTrackBasicInfo({
    String? profileImage,
    String?name,
    String? phone,
    String? address,
    int? ppm,
    String? llc,
    required BuildContext context,
  }) async {
    var body = {
      'profileImage': profileImage,
      'name': name,
      'phone': phone,
      'address': address,
      'ppm': int.tryParse(ppm.toString()),
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



  /// ================================> Tow Track Company Info ==============================>


  var companyInfoLoading = false.obs;

  Future<bool> companyInformation({
    String? companyName,
    String? companyOwner,
    String? companyPhone,
    String? companyEmail,
    String? companyAddress,
    int? yearsInBusiness,
    String? website,
    int? totalTows,
    String? einNo,
    required BuildContext context,
  }) async {
    var body = {
      'companyName': companyName,
      'companyOwner': companyOwner,
      'companyPhone': companyPhone,
      'companyEmail': companyEmail,
      'companyAddress': companyAddress,
      'yearsInBusiness': int.tryParse(yearsInBusiness.toString()),
      'website': website,
      'totalTows': int.tryParse(totalTows.toString()),
      'einNo': einNo,
    };

    companyInfoLoading(true);
    try {
      var response = await ApiClient.putData(
        ApiConstants.towTrackCompanyInfoEndPoint,
        body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // context.pushNamed(AppRoutes.licensingAndComplianceScreen);
        ToastMessageHelper.showToastMessage("${response.body["message"]}");
        return true;
      } else {
        ToastMessageHelper.showToastMessage('Submission failed. Please check inputs.', title: 'Attention');
        return false;
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong.");
      return false;
    } finally {
      companyInfoLoading(false);
    }
  }



  /// ================================> Licensing and Compliance ==============================>


  var licensingComplianceLoading = false.obs;

  Future<bool> licensingCompliance({
    String? usDotNo,
    String? usDotFile,
    String? policyNo,
    String? policyFile,
    String? mcNo,
    String? mcFile,
    int?policyLimit,
    required BuildContext context,
  }) async {
    var body = {
      'usDotNo': usDotNo,
      'usDotFile': usDotFile,
      'policyNo': policyNo,
      'policyFile': policyFile,
      'mcNo': mcNo,
      'policyLimit':int.tryParse(policyLimit.toString()),
      'mcFile':mcFile,
    };

    licensingComplianceLoading(true);

    try {
      var response = await ApiClient.putData(
        ApiConstants.towTrackLicenseComplianceEndPoint,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // context.pushNamed(AppRoutes.vehicleEquipmentScreen);
        ToastMessageHelper.showToastMessage("${response.body["message"]}");
        return true;
      } else {
        ToastMessageHelper.showToastMessage("Failed to upload dotRegistration/insurance/mc",title: 'Attention');
        return false;
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong.");
      return false;
    } finally {
      licensingComplianceLoading(false);
    }
  }


  /// =====================================> Multiple Vehicle Equipment ==============================================
  var vehiclesEquipmentLoading = false.obs;

  Future<bool> vehiclesEquipmentMultiple({
    required List<Map<String, dynamic>> vehicles,
    required BuildContext context,
  }) async {
    var body = {
      'vehicles': vehicles,
    };
    vehiclesEquipmentLoading(true);
    var response = await ApiClient.putData(
      ApiConstants.towTrackVehicleEndPoint,
      body,
    );
    vehiclesEquipmentLoading(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      return true;
    } else {
      ToastMessageHelper.showToastMessage('Failed to update vehicle data.', title: 'Attention');
      return false;
    }
  }




  // /// =====================================> Vehicle Equipment ==============================================>
  //
  // var vehiclesEquipmentLoading = false.obs;
  //
  // vehiclesEquipment({
  //   int? year,
  //   String? brand,
  //   String? modelNo,
  //   int? gvwr,
  //   String? type,
  //   String? video,
  //   required BuildContext context,
  // }) async {
  //   var body = {
  //     'vehicles': [
  //       {
  //         'year': int.tryParse(year.toString()),
  //         'brand': brand,
  //         'modelNo': modelNo,
  //         'gvwr': int.tryParse(gvwr.toString()),
  //         'type': type,
  //         'video': video,
  //
  //       }
  //     ]
  //   };
  //   vehiclesEquipmentLoading(true);
  //   var response = await ApiClient.putData(
  //       ApiConstants.towTrackVehicleEndPoint,
  //       body);
  //   vehiclesEquipmentLoading(false);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     // context.pushNamed(AppRoutes.serviceCoverageScreen);
  //     ToastMessageHelper.showToastMessage("${response.body["message"]}");
  //     return true;
  //   } else {
  //     ToastMessageHelper.showToastMessage('You must enter the current year!', title: 'Attention');
  //     return false;
  //   }
  // }

  /// =====================================> service Coverage ==============================================>

  var serviceCoverageLoading = false.obs;

  serviceCoverage({
    required List<String> services,
    required String primaryCountry,
    required String primaryState,
    required String primaryCity,
    required String regionsCovered,
    required bool emergency24_7,
    required String eta,
    required BuildContext context,
  }) async {
    var body = {
      'services': services,
      'primaryCity': primaryCity,
      'primaryCountry': primaryCountry,
      'regionsCovered': regionsCovered,
      'emergency24_7': emergency24_7,
      'eta': eta,

    };
    serviceCoverageLoading(true);
    var response = await ApiClient.putData(
        ApiConstants.towTrackServiceCoverageEndPoint,
        body);
    serviceCoverageLoading(false);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // context.pushNamed(AppRoutes.businessRequirementScreen);
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      return true;
    } else {
      ToastMessageHelper.showToastMessage('You must enter at service coverage!', title: 'Attention');
      return false;
    }
  }


  /// ================================> Business Requirements ==============================>


  var businessRequirementsLoading = false.obs;

  Future<bool> businessRequirements({
    String? authName,
    String? authTitle,
    String? authSignature,
    String? authDate,
    required BuildContext context,
  }) async {
    var body = {
      'authName': authName,
      'authTitle': authTitle,
      'authSignature': authSignature,
      'authDate': authDate,

    };

    licensingComplianceLoading(true);

    try {
      var response = await ApiClient.putData(
        ApiConstants.towBusinessRequirementsEndPoint,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // context.pushNamed(AppRoutes.towTruckBottomNavBar);
        ToastMessageHelper.showToastMessage("${response.body["message"]}");
        return true;
      } else {
        ToastMessageHelper.showToastMessage("Failed to upload dotRegistration/insurance/mc",title: 'Attention');
        return false;
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong.");
      return false;
    } finally {
      licensingComplianceLoading(false);
    }
  }


  /// ================================>  Tow Track Get Profile ==============================>

  RxBool towTrackProfileLoading = false.obs;
  Rx<TowTrackProfileModel> trackProfile = TowTrackProfileModel().obs;
  getTowTrackProfile() async {
    towTrackProfileLoading(true);
    var response = await ApiClient.getData(ApiConstants.getProfileEndPoint);
    if (response.statusCode == 200) {
      trackProfile.value = TowTrackProfileModel.fromJson(response.body['data']);
      towTrackProfileLoading(false);
    } else if (response.statusCode == 404) {
      towTrackProfileLoading(false);
    }
  }



}