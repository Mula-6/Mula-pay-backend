import 'package:flutter/material.dart';

import 'animation_wrapper.dart';

/// Fade in animation
class FadeInAnimationWarpper extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool repeat;
  final int? repeatCount;
  final bool autoStart;

  const FadeInAnimationWarpper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeIn,
    this.repeat = false,
    this.repeatCount,
    this.autoStart = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationWrapper(
      animation: AnimationType.fadeIn,
      duration: duration,
      curve: curve,
      repeat: repeat,
      repeatCount: repeatCount,
      autoStart: autoStart,
      child: child,
    );
  }
}
