import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider(
      {super.key, required this.value, this.onChanged, this.max = 5});

  final double value;
  final ValueChanged<double>? onChanged;
  final double max;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 10.h,
        tickMarkShape: SliderTickMarkShape.noTickMark,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
      ),
      child: Slider(
          value: value,
          min: 0,
          max: max,
          divisions: 5,
          activeColor: Colors.white,
          inactiveColor: const Color(0xffB0B0FF),
          thumbColor: Colors.white,
          onChanged: onChanged),
    );
  }
}
