import 'dart:async';

import 'package:autorevive/core/app_constants/app_constants.dart';
import 'package:autorevive/core/config/app_routes/app_routes.dart';
import 'package:autorevive/helpers/prefs_helper.dart';
import 'package:autorevive/helpers/time_format.dart';
import 'package:autorevive/pregentaitions/widgets/cachanetwork_image.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_listview_shimmer.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/no_data_found_card.dart';
import 'package:autorevive/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../controllers/chat_controller.dart';
import '../../../../core/constants/app_colors.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  ChatController chatController = Get.find<ChatController>();
  TextEditingController searchCtrl = TextEditingController();

  Timer? debounce;

  @override
  void initState() {
    chatController.fetchUser();
    super.initState();
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Message"),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            CustomTextField(
                controller: searchCtrl,
                hintText: "Write Name Here",
                onChanged: (value) {
                  if (debounce?.isActive ?? false) {
                    debounce?.cancel();
                  }
                  debounce = Timer(const Duration(milliseconds: 500), () {
                    chatController.chatUsers.clear();
                    chatController.fetchUser(name: searchCtrl.text);
                  });
                },
                suffixIcon: const Icon(Icons.search)),
            Expanded(
              child: Obx(
                () => chatController.fetchUserLoading.value
                    ? const ChatShimmerList()
                    : chatController.chatUsers.isEmpty
                        ? const NoDataFoundCard()
                        : ListView.builder(
                            itemCount: chatController.chatUsers.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var user = chatController.chatUsers[index];

                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: GestureDetector(
                                  onTap: () {
                                    context.pushNamed(AppRoutes.messageChatScreen, extra: {
                                      "receiverId" : "${user.receiver?.id}",
                                      "name" : "${user.receiver?.name}",
                                      "threadId" : "${user.id}"
                                    }).then((_){
                                      chatController.chatUsers.clear();
                                      chatController.fetchUser();
                                    });
                                  },
                                  child: _userCard(
                                      name: '${user.receiver?.name ?? "N/A"}',
                                      isOnline: user.receiver?.isOnline ?? false,
                                      image: "${ApiConstants.imageBaseUrl}/${user.receiver?.profileImage}",
                                      message: user.lastMessage?.content == "" ? "File" : "${user.lastMessage?.content}",
                                      time: "${TimeFormatHelper.timeWithAMPMLocalTime(DateTime.parse("${user.lastMessage?.createdAt ?? DateTime.now()}"))}" ),
                                ),
                              );
                            }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userCard(
      {required String name, message, time, image, required bool isOnline}) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black))),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Row(
          children: [
            CustomNetworkImage(
              border: Border.all(color: AppColors.primaryShade300, width: 0.2),
                imageUrl: "$image",
                height: 48.h,
                width: 48.w,
                boxShape: BoxShape.circle),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: name.toString(), fontsize: 16.h, color: Colors.black),
                  CustomText(
                      text: message.toString(),
                      fontsize: 12.h,
                      color: Colors.black87),
                ],
              ),
            ),
            const Spacer(),
            CustomText(text: time.toString(), right: 12.w),
            Container(
              height: 10.h,
              width: 10.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: isOnline ? Colors.green : Colors.grey,
                  shape: BoxShape.circle),
            )
          ],
        ),
      ),
    );
  }

}



class ChatShimmerList extends StatelessWidget {
  const ChatShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                // Circle avatar placeholder
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                 SizedBox(width: 12.w),
                // Name and message column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 12.h,
                        color: Colors.white,
                      ),
                       SizedBox(height: 6.h),
                      Container(
                        width: 100.w,
                        height: 13.h,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                 SizedBox(width: 12.w),
                // Time and status dot
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 13.h,
                      color: Colors.white,
                    ),
                     SizedBox(width: 6.h),
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
