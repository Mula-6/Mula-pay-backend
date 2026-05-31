
import 'package:flutter/material.dart';
import 'package:mobile/core/shared/ui/widgets/animations/animations.dart';

import '../../../constant/colors.dart';

class CustomCircleWidgets extends StatelessWidget {
  const CustomCircleWidgets({
    super.key,
    this.height = 400,
     this.width = 400
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return PulseAnimationWapper(
      duration: Duration(seconds: 8),
      
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.primary.withAlphaOpacity(0.2),
          boxShadow: [
            BoxShadow(
              color: KColors.primary.withAlphaOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
