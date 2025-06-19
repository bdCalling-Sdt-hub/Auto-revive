import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class ExperienceCustomCheckboxList extends StatefulWidget {
  const ExperienceCustomCheckboxList({super.key, required this.items, this.isAllChecked = false});

  final Map<String, bool> items;
  final bool isAllChecked;

  @override
  State<ExperienceCustomCheckboxList> createState() => _ExperienceCustomCheckboxListState();
}

class _ExperienceCustomCheckboxListState extends State<ExperienceCustomCheckboxList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.entries.map((entry) {
        return Row(
          children: [
            Checkbox(
              value: entry.value,
              activeColor: AppColors.primaryColor,
              side: const BorderSide(color: AppColors.primaryColor),
              onChanged: (val) {
                setState(() {
                  widget.items[entry.key] = val ?? false;
                });
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
