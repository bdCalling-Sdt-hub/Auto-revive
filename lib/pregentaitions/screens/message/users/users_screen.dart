import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/pregentaitions/widgets/cachanetwork_image.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UsersScreen extends StatelessWidget {
   UsersScreen({super.key});

  TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Message"),


      body: Padding(
        padding:  EdgeInsets.all(20.r),
        child: Column(
          children: [

            CustomTextField(controller: searchCtrl, hintText: "Write Name Here", suffixIcon: const Icon(Icons.search)),


            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                   return  Padding(
                     padding:  EdgeInsets.symmetric(vertical: 6.h),
                     child: GestureDetector(
                       onTap: () {
                         context.pushNamed(AppRoutes.messageChatScreen);
                       },
                       child: _userCard(
                           name: 'Jane Cooper',
                         isOnline: true,
                         image: "https://randomuser.me/api/portraits/women/20.jpg",
                         message: "Hello, How are you today?",
                         time: "4:50 PM"
                       ),
                     ),
                   );
                  }),
            ),
            
            



          ],
        ),
      ),

    );
  }

  Widget _userCard({required String name, message, time, image, required bool isOnline}){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black))
      ),
      child: Padding(
        padding:  EdgeInsets.all(8.r),
        child: Row(
          children: [

            CustomNetworkImage(imageUrl: "$image", height: 48.h, width: 48.w, boxShape: BoxShape.circle),

            SizedBox(width: 12.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: name.toString(), fontsize: 16.h, color: Colors.black),
                CustomText(text: message.toString(), fontsize: 12.h, color: Colors.black87),
              ],
            ),


            const  Spacer(),

            CustomText(text: time.toString(), right: 12.w),



            Container(
              height: 10.h,
              width: 10.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: isOnline ? Colors.green : Colors.grey,
                  shape: BoxShape.circle
              ),
            )


          ],
        ),
      ),
    );
  }
}
