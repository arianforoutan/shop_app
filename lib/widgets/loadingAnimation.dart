import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shop_app/constants/colors.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 64,
      width: 64,
      child: LoadingIndicator(
        indicatorType: Indicator.orbit,
        colors: [CustomColors.blueIndicator],
        strokeWidth: 5,
      ),
    );
  }
}
