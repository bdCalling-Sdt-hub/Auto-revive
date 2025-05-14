
import 'package:autorevive/controllers/customer/customer_home_controller.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/customer/customer_booking_controller.dart';

class DependencyInjection implements Bindings {

  DependencyInjection();

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => CustomerHomeController(), fenix: true);
    Get.lazyPut(() => CustomerBookingController(), fenix: true);
  }
}