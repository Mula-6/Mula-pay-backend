

import 'package:flutter/material.dart';
import 'package:mobile/core/shared/ui/widgets/animations/animation_wrapper.dart';

class FadeOutAnimationWrapper extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool repeat;
  final int? repeatCount;
  final bool autoStart;

  const FadeOutAnimationWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOut,
    this.repeat = false,
    this.repeatCount,
    this.autoStart = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationWrapper(
      animation: AnimationType.fadeOut,
      duration: duration,
      curve: curve,
      repeat: repeat,
      repeatCount: repeatCount,
      autoStart: autoStart,
      child: child,
    );
  }
}
