import 'dart:io';
import 'package:autorevive/helpers/toast_message_helper.dart';
import 'package:autorevive/pregentaitions/widgets/cachanetwork_image.dart';
import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_loader.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:autorevive/pregentaitions/widgets/no_data_found_card.dart';
import 'package:autorevive/services/api_constants.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../controllers/chat_controller.dart';
import '../../../../core/constants/app_colors.dart';

class MessageChatScreen extends StatefulWidget {
  MessageChatScreen({super.key});

  @override
  State<MessageChatScreen> createState() => _MessageChatScreenState();
}

class _MessageChatScreenState extends State<MessageChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  ChatController chatController = Get.find<ChatController>();
  final ScrollController _scrollController = ScrollController();
  String threadId = "";

  @override
  void initState() {
    chatController.listenMessage();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
        } else {
          chatController.loadMore();
          print("====> scroll bottom");
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    chatController.clearChats();
    chatController.offListenMessage();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map routeData = GoRouterState.of(context).extra as Map;
    chatController.fetchChat(receiverId: routeData["receiverId"]);
    return Scaffold(
      appBar: CustomAppBar(title: "${routeData["name"]}"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => chatController.chatLoading.value ? const CustomLoader() :  chatController.chats.isEmpty
                        ? const NoDataFoundCard()
                        : ListView.builder(
                            controller: _scrollController,
                            reverse: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            itemCount: chatController.chats.length,
                            itemBuilder: (context, index) {

                              if(index < chatController.chats.length){
                                final message = chatController.chats[index];
                                final isSender = routeData["receiverId"] != message.senderId;

                                threadId = message.threadId.toString();

                                return Column(
                                  crossAxisAlignment: isSender
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    message.content == ""
                                        ? BubbleNormalImage(
                                      id: 'image_${message.id}',
                                      image: CustomNetworkImage(
                                        imageUrl: "${ApiConstants.imageBaseUrl}/${message.attachments?.first}",
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                      // isSender: isSender,
                                      color: Colors.transparent
                                    )
                                        :
                                    BubbleNormal(
                                      text: "${message.content}",
                                      isSender: isSender,
                                      color: isSender
                                          ? AppColors.primaryColor
                                          : AppColors.fontColorFEFEFE,
                                      seen: isSender,
                                      textStyle: TextStyle(
                                        color: isSender
                                            ? Colors.white
                                            : Colors.black87,
                                        fontSize: 16.sp
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                  ],
                                );
                              }else if(index >= chatController.totalResult){
                                return null;
                              }else{
                                return const CustomLoader();
                              }


                            },
                          ),
              ),
            ),
            if (pickedFiles.isNotEmpty)
              Container(
                height: 100.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pickedFiles.length,
                  itemBuilder: (context, index) {
                    final file = pickedFiles[index];
                    final isImage = ['jpg', 'jpeg', 'png']
                        .contains(file.path.split('.').last.toLowerCase());

                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.w),
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: isImage
                              ? Image.file(file, fit: BoxFit.cover)
                              : Center(
                                  child: Icon(
                                    Icons.insert_drive_file,
                                    size: 40.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                pickedFiles.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                size: 20.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: pickAnyFile,
                    child: const Icon(Icons.attachment_outlined),
                  ),
                  SizedBox(width: 12.w),
                  Flexible(
                    child: CustomTextField(
                      validator: (value) {},
                      controller: _messageController,
                      hintText: "Message",
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            chatController.sendMessage(
                              receiveId: routeData["receiverId"],
                              content: _messageController.text,
                              threadId:   routeData["threadId"] ?? threadId,
                            );
                            _messageController.clear();
                          } else {
                            chatController.uploadFile(images: pickedFiles, receiveId: routeData["receiverId"], threadId: routeData["threadId"] ?? threadId);
                            pickedFiles.clear();
                            setState(() {

                            });
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<File> pickedFiles = [];

  Future<void> pickAnyFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'jpeg'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      setState(() {
        pickedFiles.addAll(files);
      });
    }
  }
}
