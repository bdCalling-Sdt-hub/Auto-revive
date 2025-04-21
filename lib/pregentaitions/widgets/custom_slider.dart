import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider(
      {super.key,
      required this.value,
      this.onChanged,
      this.max = 5,
      this.activeColor,
      this.inactiveColor,
      this.thumbColor});

  final double value;
  final ValueChanged<double>? onChanged;
  final double max;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 8.h,
        tickMarkShape: SliderTickMarkShape.noTickMark,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
      ),
      child: Slider(
          value: value,
          min: 0,
          max: max,
          divisions: 5,
          activeColor: activeColor ?? Colors.white,
          inactiveColor: inactiveColor ?? const Color(0xffB0B0FF),
          thumbColor: thumbColor ?? Colors.white,
          onChanged: onChanged),
    );
  }
}
