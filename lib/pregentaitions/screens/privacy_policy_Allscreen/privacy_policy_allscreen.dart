import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../global/custom_assets/assets.gen.dart';
import '../../widgets/custom_text.dart';


class PrivacyAllScreen extends StatefulWidget {


  PrivacyAllScreen({super.key});

  @override
  State<PrivacyAllScreen> createState() => _PrivacyAllScreenState();
}

class _PrivacyAllScreenState extends State<PrivacyAllScreen> {


  @override
  Widget build(BuildContext context) {

    String routeDate = GoRouterState.of(context).extra as String;


    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: CustomText(text: routeDate.toString(), fontsize: 20.h),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
                  //  HtmlWidget(policyAllController.content.value,
                  // textStyle: TextStyle(
                  //   fontWeight: FontWeight.w400,
                  //   color: Colors.white,
                  //   fontSize: 14.h,
                  // )),
              CustomText(
                textAlign: TextAlign.start,
                maxline: 20,
                text: "Lorem ipsum dolor sit amet consectetur. Enim massa aenean ac odio leo habitasse tortor tempor. Ut id urna odio dui leo congue. Ultrices pharetra ornare nam faucibus. Integer id varius consectetur non. \n\n\n Lorem ipsum dolor sit amet consectetur. Enim massa aenean ac odio leo habitasse tortor tempor. Ut id urna odio dui leo congue. Ultrices pharetra ornare nam faucibus. Integer id varius consectetur non.       \n\n\nLorem ipsum dolor sit amet consectetur. Enim massa aenean ac odio leo habitasse tortor tempor. Ut id urna odio dui leo congue. Ultrices pharetra ornare nam faucibus. Integer id varius consectetur non.",),

            ],
          ),
        ),
      ),
    );
  }
}
