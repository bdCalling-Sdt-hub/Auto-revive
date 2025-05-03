import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../helpers/toast_message_helper.dart';
import '../services/api_client.dart';

class UploadController extends GetxController {
  RxBool uploadFileLoading = false.obs;

  Future<String?> uploadFile({required File file}) async {
    uploadFileLoading(true);

    try {
      List<MultipartBody> multipartBody = [
        MultipartBody("file", file)
      ];

      var response = await ApiClient.postMultipartData(
          "/upload",
          {},
          multipartBody: multipartBody
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.body is String ? jsonDecode(response.body) : response.body;
        var dataContainer = responseData["data"];
        String uploadedFilePath = dataContainer["path"];
        ToastMessageHelper.showToastMessage("File uploaded successfully!");
        uploadFileLoading(false);
        return uploadedFilePath;
      } else {
        uploadFileLoading(false);
        ToastMessageHelper.showToastMessage("File upload failed!");
        return null;
      }
    } catch (e) {
      uploadFileLoading(false);
      ToastMessageHelper.showToastMessage("An error occurred during upload.");
      return null;
    }
  }
}
