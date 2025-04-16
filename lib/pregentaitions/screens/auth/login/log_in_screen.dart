import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogInScreen extends StatelessWidget {
   LogInScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [

            Assets.icons.logoSVG.svg(),



            SizedBox(height: 10,),

            CustomTextField(controller: emailCtrl, hintText: "Enter E-mail", isEmail: true),
            CustomTextField(controller: emailCtrl, hintText: "Enter Password", isPassword: true),

          ],
        ),
      ),
    );
  }
}
