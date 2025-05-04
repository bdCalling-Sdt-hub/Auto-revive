import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EquipmentCustomCheckboxList extends StatelessWidget {
  const EquipmentCustomCheckboxList({
    super.key,
    required this.items,
    required this.onChanged,
    this.isAllChecked = false,
  });

  final Map<String, bool> items;
  final bool isAllChecked;
  final Function(String key, bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.entries.map((entry) {
        return Row(
          children: [
            Checkbox(
              value: entry.value,
              activeColor: AppColors.primaryColor,
              side: const BorderSide(color: AppColors.primaryColor),
              onChanged: (val) {
                onChanged(entry.key, val ?? false);
              },
            ),
            Expanded(
              child: CustomText(
                fontsize: 13.sp,
                maxline: 3,
                textAlign: TextAlign.start,
                text: entry.key,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
