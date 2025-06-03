import 'dart:convert';

import 'package:get/get.dart';
import '../../services/api_client.dart';
import '../models/notifications_model.dart';


class NotificationsController extends GetxController{


  RxInt page = 1.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  var totalResult = (-1);

  void loadMore() {
    print("==========================================total page ${totalPage} page No: ${page.value} == total result ${totalResult}");
    if (totalPage > page.value) {
      page.value += 1;
      getNotifications();
      print("**********************print here");
      update();
    }
    print("**********************print here**************");
  }

  RxBool notificationLoading = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;



  getNotifications()async{
    if(page.value == 1){
      notificationLoading(true);
    }
    var response = await ApiClient.getData("/notification?page=${page.value}");
    if(response.statusCode == 200){
      totalPage = jsonDecode(response.body['pagination']['totalPage'].toString()) ?? 0;
      currentPage = jsonDecode(response.body['pagination']['currentPage'].toString()) ?? 0;
      totalResult = jsonDecode(response.body['pagination']['totalData'].toString()) ?? 0;
      var data  = List<NotificationModel>.from(response.body["data"].map((x)=> NotificationModel.fromJson(x)));
      notifications.assignAll(data);
      update();
      notificationLoading(false);
    }else{
      notificationLoading(false);
    }
  }






  ///****************************************************************************///


  // void listenNotification() async {
  //   try {
  //     SocketServices.socket.on("notification", (data) {
  //       print("=========> Response Message: $data -------------------------");
  //       if (data != null) {
  //         NotificationModel demoData = NotificationModel.fromJson(data);
  //         // print("---------------demoData: ${demoData.senderId} \n ${demoData.runtimeType}");
  //         notifications.insert(0, demoData);
  //         increaseNotificationCount();
  //         update();
  //         print('Message added to chatMessages list');
  //       } else {
  //         print("No message data found in the response");
  //       }
  //     });
  //   } catch (e, s) {
  //     print("Error: $e");
  //     print("Stack Trace: $s");
  //   }
  // }
  //
  //
  //
  //
  // RxBool unReadLoading = false.obs;
  // RxString unreadCount = ''.obs;
  // unReadCount()async{
  //   unReadLoading(true);
  //   var response = await ApiClient.getData("/notification/badge-count");
  //   if(response.statusCode == 200){
  //     unreadCount.value = response.body["data"]["unreadCount"].toString();
  //     update();
  //     notificationLoading(false);
  //   }else{
  //     notificationLoading(false);
  //   }
  // }
  //
  //
  //
  //
  // void increaseNotificationCount() {
  //   int count = int.tryParse(unreadCount.value) ?? 0;
  //   unreadCount.value = (count + 1).toString();
  //   update();
  // }

}