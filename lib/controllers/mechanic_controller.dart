import 'package:autorevive/models/get_all_experience_model.dart';
import 'package:autorevive/models/get_tools_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../services/api_client.dart';
import '../core/app_constants/app_constants.dart';
import '../core/config/app_routes/app_routes.dart';
import '../helpers/prefs_helper.dart';
import '../helpers/toast_message_helper.dart';
import '../models/get_profile_model.dart';
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

  /// ================================> Get Profile ==============================>

  RxBool getProfileLoading = false.obs;
  Rx<GetProfileModel> profile = GetProfileModel().obs;
  getProfile() async {
    getProfileLoading(true);
    var response = await ApiClient.getData(ApiConstants.getProfileEndPoint);
    if (response.statusCode == 200) {
      profile.value = GetProfileModel.fromJson(response.body['data']);
      update();
      getProfileLoading(false);
    } else if (response.statusCode == 404) {
      getProfileLoading(false);
    }
  }



/// ================================> Mechanic Basic Info ==============================>


  var basicInfoLoading = false.obs;

  Future<bool> mechanicBasicInfo({
    String? profileImage,
    String? name,
    String? platform,
    String? phone,
    String? address,
    bool? haveLicense,
    bool? haveCdl,
    required BuildContext context,
  }) async {
    var body = {
      'profileImage': profileImage,
      'platform': platform,
      'phone': phone,
      'address': address,
      'haveLicense': haveLicense,
      'haveCdl': haveCdl,
      'name':name
    };

    basicInfoLoading(true);

    try {
      var response = await ApiClient.putData(
        ApiConstants.mechanicBasicInfoEndPoint,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // context.pushNamed(AppRoutes.mechanicExperienceSkillScreen);
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


  // Future<void> mechanicBasicInfo({
  //   String? profileImage,
  //   String? platform,
  //   String? phone,
  //   String? address,
  //   bool? haveLicense,
  //   bool? haveCdl,
  //   required BuildContext context,
  // }) async {
  //   var body = {
  //     'profileImage': profileImage,
  //     'platform': platform,
  //     'phone': phone,
  //     'address': address,
  //     'haveLicense': haveLicense,
  //     'haveCdl': haveCdl,
  //   };
  //
  //   basicInfoLoading(true);
  //
  //   try {
  //     var response = await ApiClient.putData(
  //       ApiConstants.mechanicBasicInfoEndPoint,
  //       body,
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       ToastMessageHelper.showToastMessage("${response.body["message"]}");
  //       context.pushNamed(AppRoutes.mechanicExperienceSkillScreen);
  //     } else {
  //       ToastMessageHelper.showToastMessage("Select profile image!");
  //     }
  //   } catch (e) {
  //     ToastMessageHelper.showToastMessage("Something went wrong.");
  //   } finally {
  //     basicInfoLoading(false);
  //   }
  // }
  //



  /// ================================> Experience and certification ==============================>


  var experienceCertificationsLoading = false.obs;

  Future<bool> experienceCertifications({
    required List<Map<String, dynamic>> experiences,
    required List<String> certifications,
    required BuildContext context,
  }) async {
    var body = {
      'experiences': experiences,
      'certifications': certifications,
    };

    experienceCertificationsLoading(true);

    var response = await ApiClient.putData(
      ApiConstants.experienceCertificationsEndPoint,
      body,
    );

    experienceCertificationsLoading(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      return true;
    } else {
      ToastMessageHelper.showToastMessage("Failed to save experience data.");
      return false;
    }
  }

  /// ================================> Tools Equipment ==============================>


  var mechanicToolsLoading = false.obs;

  Future<bool> mechanicTools({
    required List<String> tools,
    required List<String> toolsCustom,
    required BuildContext context,
  }) async {
    var body = {
      'tools': tools,
      'toolsCustom': toolsCustom,
    };
    mechanicToolsLoading(true);
    var response = await ApiClient.putData(
      ApiConstants.mechanicToolsEndPoint,
      body,
    );
    mechanicToolsLoading(false);
    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      return true;
    } else {
      ToastMessageHelper.showToastMessage("Failed to tools data.");
      return false;
    }
  }


  /// ================================> Employment History ==============================>

  var employmentHistoriesLoading = false.obs;

  employmentHistories({
    String? companyName,
    String? jobName,
    String? supervisorsName,
    String? supervisorsContact,
    String? durationFrom,
    String? durationTo,
    String? platform,
    String? reason,
    required BuildContext context,
  }) async {
    var body = {
      'employmentHistories': [
        {
          'companyName': companyName,
          'jobName': jobName,
          'supervisorsName': supervisorsName,
          'supervisorsContact': supervisorsContact,
          'durationFrom': durationFrom,
          'durationTo': durationTo,
          'platform': platform,
          'reason': reason,
        }
      ]
    };
    employmentHistoriesLoading(true);
    var response = await ApiClient.putData(
        ApiConstants.mechanicEmploymentHistoriesEndPoint,
        body);
    employmentHistoriesLoading(false);
    if (response.statusCode == 200 || response.statusCode == 201) {
      context.pushNamed(AppRoutes.mechanicReferenceScreen);
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      return true;
    } else {
      ToastMessageHelper.showToastMessage('You must enter at least one Platform!', title: 'Attention');
      return false;
    }
  }



  /// ================================> Reference ==============================>

  var referenceLoading = false.obs;

  Future<bool> referencesList({
    required List<Map<String, String>> references,
    required BuildContext context,
  }) async {
    var body = {'references': references};

    referenceLoading(true);
    var response = await ApiClient.putData(
      ApiConstants.referenceEndPoint,
      body,
    );
    referenceLoading(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // context.pushNamed(AppRoutes.mechanicAdditionalInformationScreen);
      ToastMessageHelper.showToastMessage("${response.body["message"]}");
      return true;
    } else {
      ToastMessageHelper.showToastMessage("Failed to submit references.");
      return false;
    }
  }


  /// ================================> Additional Information ==============================>


  var additionalInformationLoading = false.obs;

  Future<bool> additionalInformation({
    String? whyOnSite,
    required BuildContext context,
  }) async {
    var body = {
      'whyOnSite': whyOnSite,
    };

    additionalInformationLoading(true);

    try {
      var response = await ApiClient.putData(
        ApiConstants.additionalInformationEndPoint,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // context.pushNamed(AppRoutes.mechanicResumeCertificateScreen);
        ToastMessageHelper.showToastMessage("${response.body["message"]}");
        return true;
      } else {
        ToastMessageHelper.showToastMessage("Something went wrong.");
        return false;
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Failed to submit additional information.");
      return false;
    } finally {
      additionalInformationLoading(false);
    }
  }


  // Future<void> additionalInformation({
  //   String? whyOnSite,
  //   required BuildContext context,
  // }) async {
  //   var body = {
  //     'whyOnSite': whyOnSite,
  //   };
  //
  //   additionalInformationLoading(true);
  //
  //   try {
  //     var response = await ApiClient.putData(
  //       ApiConstants.additionalInformationEndPoint,
  //       body,
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       ToastMessageHelper.showToastMessage("${response.body["message"]}");
  //       context.pushNamed(AppRoutes.mechanicResumeCertificateScreen);
  //     } else {
  //       ToastMessageHelper.showToastMessage("Something went wrong.");
  //     }
  //   } catch (e) {
  //     ToastMessageHelper.showToastMessage("Failed to submit additional information.");
  //   } finally {
  //     additionalInformationLoading(false);
  //   }
  // }


  /// ================================> Resume Certificate ==============================>


  var resumeCertificateLoading = false.obs;

  Future<bool> resumeCertificate({
    String? resume,
    String? certificate,
    required BuildContext context,
  }) async {
    var body = {
      'resume': resume,
      'certificate': certificate,
    };

    resumeCertificateLoading(true);

    try {
      var response = await ApiClient.putData(
        ApiConstants.mechanicResumeCertificateEndPoint,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.showToastMessage("${response.body["message"]}");
        // context.pushNamed(AppRoutes.mechanicProfileInformationScreen);
        return true;
      } else {
        ToastMessageHelper.showToastMessage("Failed to upload resume/certificate.");
        return false;
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong.");
      return false;
    } finally {
      resumeCertificateLoading(false);
    }
  }


  // Future<void> resumeCertificate({
  //   String? resume,
  //   String? certificate,
  //   required BuildContext context,
  // }) async {
  //   var body = {
  //     'resume': resume,
  //     'certificate': certificate,
  //   };
  //
  //   resumeCertificateLoading(true);
  //
  //   try {
  //     var response = await ApiClient.putData(
  //       ApiConstants.mechanicResumeCertificateEndPoint,
  //       body,
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       ToastMessageHelper.showToastMessage("${response.body["message"]}");
  //       context.pushNamed(AppRoutes.mechanicProfileInformationScreen);
  //     } else {
  //       ToastMessageHelper.showToastMessage("Failed to upload resume/certificate.");
  //     }
  //   } catch (e) {
  //
  //     ToastMessageHelper.showToastMessage("Something went wrong.");
  //   } finally {
  //     resumeCertificateLoading(false);
  //   }
  // }























  RxString name = "".obs;
  RxString image = "".obs;
  RxString myUserId = "".obs;
  RxString role = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString address = "".obs;


  getLocalData()async{
    name.value = await PrefsHelper.getString(AppConstants.name);
    image.value = await PrefsHelper.getString(AppConstants.image);
    myUserId.value = await PrefsHelper.getString(AppConstants.userId);
    role.value = await PrefsHelper.getString(AppConstants.role);
    email.value = await PrefsHelper.getString(AppConstants.email);
    phone.value = await PrefsHelper.getString(AppConstants.phone);
    address.value = await PrefsHelper.getString(AppConstants.address);
    print("=================================local Data fetched");
    update();
  }




  var updateProfileCustomerLoading = false.obs;

  customerUpdateProfile({
    String? name,
    String? phone, address, profileImage, passPort, required BuildContext context

  }) async {

    updateProfileCustomerLoading(true);

    var body = {
      'name': "$name",
      'phone': "$phone",
      "address" : "$address",
      "filePath" : "$passPort",
      "profileImage" : "$profileImage"
    };


    updateProfileCustomerLoading(true);

    var response = await ApiClient.putData(
      ApiConstants.getProfileEndPoint,
      body,
    );



    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage("${response.body["message"]}");

      context.pop();
      updateProfileCustomerLoading(false);
      update();
    } else {
      updateProfileCustomerLoading(false);
      ToastMessageHelper.showToastMessage("Failed to save experience data.");
    }
  }


}