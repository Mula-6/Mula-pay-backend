

import 'package:flutter/material.dart';
import 'package:mobile/core/shared/ui/widgets/animations/animation_wrapper.dart';

/// ShimerAnimationWrapper animation
class ShimerAnimationWrapper extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final bool repeat;
  final int? repeatCount;
  final bool autoStart;

  const ShimerAnimationWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.repeat = false,
    this.repeatCount,
    this.autoStart = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationWrapper(
      animation: AnimationType.shimmer,
      duration: duration,
      curve: Curves.linear,
      repeat: repeat,
      repeatCount: repeatCount,
      autoStart: autoStart,
      child: child,
    );
  }
}
