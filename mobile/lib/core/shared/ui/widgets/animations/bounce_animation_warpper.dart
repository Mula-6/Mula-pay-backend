
import 'package:flutter/material.dart';
import 'package:mobile/core/shared/ui/widgets/animations/animation_wrapper.dart';

/// BounceAnimationWarpper animation
class BounceAnimationWarpper extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final bool repeat;
  final int? repeatCount;
  final bool autoStart;
  final double intensity;

  const BounceAnimationWarpper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.repeat = false,
    this.repeatCount,
    this.autoStart = true,
    this.intensity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationWrapper(
      animation: AnimationType.bounce,
      duration: duration,
      curve: Curves.bounceOut,
      repeat: repeat,
      repeatCount: repeatCount,
      autoStart: autoStart,
      intensity: intensity,
      child: child,
    );
  }
}