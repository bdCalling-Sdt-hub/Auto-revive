import 'dart:io';

import 'package:autorevive/core/app_constants/app_constants.dart';
import 'package:autorevive/helpers/prefs_helper.dart';
import 'package:autorevive/services/socket_services.dart';
import 'package:get/get.dart';

import '../helpers/toast_message_helper.dart';
import '../models/chat_model.dart';
import '../models/chat_user_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class ChatController extends GetxController {
  RxList<ChatModel> chats = <ChatModel>[].obs;
  RxBool chatLoading = false.obs;

  fetchChat({String? receiverId}) async {
    chatLoading(true);
    var response =
        await ApiClient.getData(ApiConstants.message("${receiverId ?? ""}"));

    if (response.statusCode == 200) {
      chats.value = List<ChatModel>.from(
          response.body["data"].map((x) => ChatModel.fromJson(x)));
      chatLoading(false);
    }
    chatLoading(false);
  }

  RxList<ChatUserModel> chatUsers = <ChatUserModel>[].obs;
  RxBool fetchUserLoading = false.obs;

  fetchUser() async {
    fetchUserLoading(true);
    var response = await ApiClient.getData(ApiConstants.chatUser);

    if (response.statusCode == 200) {
      chatUsers.value = List<ChatUserModel>.from(
          response.body["data"].map((x) => ChatUserModel.fromJson(x)));

      fetchUserLoading(false);
    }
    fetchUserLoading(false);
  }



  uploadFile({required List<File> images, String? receiveId, threadId}) async {
    List<MultipartBody> photoList =
        images.map((file) => MultipartBody("files", file)).toList();

    var response = await ApiClient.postMultipartData(
      "/upload/multiple",
      {},
      multipartBody: photoList,
    );

    if (response.status == 200 || response.status == 201) {
      List<String> filenames = List<String>.from(response.body["data"]);

      sendMessage(threadId: "$threadId",content: "",receiveId: "$receiveId", filePath: filenames);

    } else {
      ToastMessageHelper.showToastMessage("Failed to upload files");
    }
  }

  ///=======================Socket ====================>>>>

  SocketServices socketServices = SocketServices();

  void listenMessage() async {
    socketServices.socket.on("message-receive", (data) {
      if (data != null) {
        ChatModel demoData = ChatModel.fromJson(data);
        chats.insert(0, demoData);

        update();

        print('Message added to chatMessages list');
      } else {
        print("No message data found in the response");
      }
    });
  }

  createChat({String? content, receiveId}) async {
    var myId = await PrefsHelper.getString(AppConstants.userId);

    var body = {
      "senderId": "$myId",
      "content": "$content",
      "participants": ["$myId", "$receiveId"]
    };

    socketServices.emit("message-send", body);
  }

  sendMessage({String? content, receiveId, threadId, filePath}) async {
    var myId = await PrefsHelper.getString(AppConstants.userId);

    var body = filePath != null
        ? {
            "senderId": "$myId",
            "threadId": "$threadId",
            "content": "$content",
          }
        : {
            "senderId": "$myId",
            "threadId": "$threadId",
            "content": "$content",
            "attachments": [filePath.toString()]
          };

    socketServices.emit("message-send", body);
  }
}
