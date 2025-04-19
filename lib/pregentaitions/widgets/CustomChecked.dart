import 'package:autorevive/core/constants/app_colors.dart';
import 'package:autorevive/pregentaitions/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomChecked extends StatelessWidget {
  const CustomChecked(
      {super.key, required this.selected, required this.onChanged, this.title});

  final bool? selected;
  final String? title;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title != null)
        CustomText(
          text: title ?? '',
        ),
        Row(
          children: [
            Checkbox(
              side: const BorderSide(color: AppColors.primaryColor),
              activeColor: AppColors.primaryColor,
              value: selected == true,
              onChanged: (_) => onChanged(true),
            ),
            CustomText(text: 'Yes'),
            Checkbox(
                side: const BorderSide(color: AppColors.primaryColor),
                activeColor: AppColors.primaryColor,
                value: selected == false,
              onChanged: (_) => onChanged(false),
            ),
            CustomText(text: 'No'),
          ],
        ),
      ],
    );
  }
}
