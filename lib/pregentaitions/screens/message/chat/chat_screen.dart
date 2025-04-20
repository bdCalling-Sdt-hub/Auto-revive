import 'package:autorevive/pregentaitions/widgets/custom_app_bar.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text_field.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class MessageChatScreen extends StatelessWidget {
  MessageChatScreen({super.key});

  final TextEditingController _messageController = TextEditingController();

// Dummy chat data
  final List messages = [
    {"sender": "Jane", "receiver": "You", "text": "Hey! How are you doing?"},
    {
      "sender": "You",
      "receiver": "Jane",
      "text": "I'm doing well, thanks! You?"
    },
    {
      "sender": "Jane",
      "receiver": "You",
      "text": "Just got back from work. It was a hectic day."
    },
    {"sender": "You", "receiver": "Jane", "text": "Oh wow, take some rest!"},
    {
      "sender": "Jane",
      "receiver": "You",
      "text": "Will do. Wanna catch up this weekend?"
    },
    {
      "sender": "You",
      "receiver": "Jane",
      "text": "Absolutely! Let’s plan something."
    },
    {
      "sender": "Jane",
      "receiver": "You",
      "text": "How about brunch on Saturday?"
    },
    {
      "sender": "You",
      "receiver": "Jane",
      "text": "Sounds perfect. Same place as last time?"
    },
    {
      "sender": "Jane",
      "receiver": "You",
      "text": "Yeah, the café by the park. 11 AM?"
    },
    {
      "sender": "You",
      "receiver": "Jane",
      "text": "Works for me! Looking forward to it."
    },
    {"sender": "Jane", "receiver": "You", "text": "Same here 😊"},
    {
      "sender": "You",
      "receiver": "Jane",
      "text": "By the way, did you watch the new episode of that series?"
    },
    {"sender": "Jane", "receiver": "You", "text": "Not yet! Don’t spoil it 😅"},
    {
      "sender": "You",
      "receiver": "Jane",
      "text": "Haha alright, but you’re gonna love it."
    },
    {
      "sender": "Jane",
      "receiver": "You",
      "text": "Okay okay, I’ll watch it tonight."
    },
    {
      "sender": "You",
      "receiver": "Jane",
      "text": "Cool! Let me know what you think."
    },
    {"sender": "Jane", "receiver": "You", "text": "Will do. Talk soon!"},
    {"sender": "You", "receiver": "Jane", "text": "Take care, Jane."},
    {"sender": "Jane", "receiver": "You", "text": "You too! 👋"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Jane Cooper"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages.reversed.toList()[index];
                  final isSender = message['sender'] == "You";

                  return Column(
                    crossAxisAlignment: isSender
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      BubbleNormal(
                        text: message['text'],
                        isSender: isSender,
                        color: isSender
                            ? AppColors.primaryColor
                            : AppColors.fontColorFEFEFE,
                        tail: true,
                        seen: isSender ? true : false,
                        sent: true,
                        textStyle: TextStyle(
                          color: isSender ? Colors.white : Colors.black87,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
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
                    onTap: () {},
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
                              _messageController.clear();
                            },
                            icon: const Icon(Icons.send),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
