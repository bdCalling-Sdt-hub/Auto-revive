import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../controllers/settings_controller.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/custom_text.dart';


class PrivacyAllScreen extends StatefulWidget {

  PrivacyAllScreen({super.key});
  @override
  State<PrivacyAllScreen> createState() => _PrivacyAllScreenState();

}

class _PrivacyAllScreenState extends State<PrivacyAllScreen> {

  SettingsController settingsController = Get.put(SettingsController());

 @override
  void dispose() {
    settingsController.value.value = '';
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    String routeDate = GoRouterState.of(context).extra as String;
    settingsController.privacyPolicy(name:routeDate=="Privacy Policy"? "privacy-policy": routeDate== "Terms & Conditions"?"terms-conditions" :"about-us");
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: CustomText(text: routeDate.toString(), fontsize: 20.h),
      ),
      body: Obx(()=>
      settingsController.getPrivacyPolicyLoading.value
          ?  CustomLoader(top: 20.h)
          : settingsController.value.isEmpty
          ? Center(child: CustomText(text: "No Data Found!", top: 300.h))
          : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  maxline: 20,
                  text: settingsController.value.value),

              ],
            ),
          ),
        )),
    );
  }
}
