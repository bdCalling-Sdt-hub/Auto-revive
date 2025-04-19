import 'package:autorevive/pregentaitions/widgets/custom_container.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({
    super.key,
    required this.items,
    required this.onSelected,
  });

  final List<String> items;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      //constraints: BoxConstraints(maxHeight: 200.h),
      color: Colors.white,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((String item) {
          return PopupMenuItem<String>(
            padding: EdgeInsets.zero,
            height: 24.h,
            value: item,
            child: CustomContainer(
                width: double.infinity,
                border: const Border(
                    bottom: BorderSide(color: Colors.black, width: 0.7)),
                child: CustomText(text: item, fontsize: 12.sp)),
          );
        }).toList();
      },
    );
  }
}
