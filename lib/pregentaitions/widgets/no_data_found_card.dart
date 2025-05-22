import 'package:autorevive/global/custom_assets/assets.gen.dart';
import 'package:flutter/cupertino.dart';

class NoDataFoundCard extends StatelessWidget {
  const NoDataFoundCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Assets.lottie.noData.lottie(),
    );
  }
}
