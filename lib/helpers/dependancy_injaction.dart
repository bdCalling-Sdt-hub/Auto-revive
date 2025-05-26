
import 'package:autorevive/controllers/customer/customer_home_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/chat_controller.dart';
import '../controllers/current_location_controller.dart';
import '../controllers/customer/customer_booking_controller.dart';
import '../controllers/live_location_change_controller.dart';
import '../controllers/mechanic_controller/mechanic_job_controller.dart';

class DependencyInjection implements Bindings {

  DependencyInjection();

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => CustomerHomeController(), fenix: true);
    Get.lazyPut(() => CustomerBookingController(), fenix: true);
    Get.lazyPut(() => MechanicJobController(), fenix: true);
    Get.lazyPut(() => CurrentLocationController(), fenix: true);
    Get.lazyPut(() => LiveLocationChangeController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
  }

  void lockDevicePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}