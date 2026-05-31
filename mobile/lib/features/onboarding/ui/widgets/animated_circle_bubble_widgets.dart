
import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/helpers/helper.dart';
import '../../../../core/shared/shared.dart';

class AnimatedCircleBubbleWidgets extends StatelessWidget {
  final Animation<double> scaleAnimation;
  final Animation<double> pulseAnimation;
  final Animation<double> rotateAnimation;

  const AnimatedCircleBubbleWidgets({
    super.key,
    required this.scaleAnimation,
    required this.pulseAnimation,
    required this.rotateAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -40,
          right: -40,
          child: SlideInAnimationWapper(
            duration: const Duration(milliseconds: 800),
            direction: AnimationDirection.rightToLeft,
            child: AnimatedBuilder(
              animation: pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: pulseAnimation.value,
                  child: child,
                );
              },
              child: Container(
                width: KDevice.getWidth(context) * 0.55,
                height: KDevice.getWidth(context) * 0.55,
                decoration: BoxDecoration(
                  color: KColors.borderDark.withAlphaOpacity(0.3),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: KColors.borderDark.withAlphaOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Top Right Circle 2 (Primary color, rotating)
        Positioned(
          top: -60,
          right: -60,
          child: SlideInAnimationWapper(
            duration: const Duration(milliseconds: 1000),
            direction: AnimationDirection.rightToLeft,
            delay: const Duration(milliseconds: 200),
            child: AnimatedBuilder(
              animation: rotateAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: rotateAnimation.value,
                  child: Transform.scale(
                    scale: 0.98 + 0.04 * scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: Container(
                width: KDevice.getWidth(context) * 0.6,
                height: KDevice.getWidth(context) * 0.55,
                decoration: BoxDecoration(
                  color: KColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),

        // Bottom Right Circle (Primary color, pulsing)
        Positioned(
          bottom: -60,
          right: -100,
          child: SlideInAnimationWapper(
            duration: const Duration(milliseconds: 1200),
            direction: AnimationDirection.bottomToTop,
            delay: const Duration(milliseconds: 400),
            child: AnimatedBuilder(
              animation: pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: pulseAnimation.value,
                  child: child,
                );
              },
              child: Container(
                width: KDevice.getWidth(context) * 0.6,
                height: KDevice.getWidth(context) * 0.55,
                decoration: BoxDecoration(
                  color: KColors.primary.withAlphaOpacity(0.8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: KColors.primary.withAlphaOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Bottom Left Circle (Subtle, scaling)
        Positioned(
          bottom: -40,
          left: -40,
          child: SlideInAnimationWapper(
            duration: const Duration(milliseconds: 1000),
            direction: AnimationDirection.leftToRight,
            delay: const Duration(milliseconds: 300),
            child: AnimatedBuilder(
              animation: scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: scaleAnimation.value,
                  child: child,
                );
              },
              child: Container(
                width: KDevice.getWidth(context) * 0.55,
                height: KDevice.getWidth(context) * 0.55,
                decoration: BoxDecoration(
                  color: KColors.borderDark.withAlphaOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),

        // Additional floating circles (optional)
        Positioned(
          top: KDevice.getHeight(context) * 0.15,
          left: -30,
          child: BounceAnimationWarpper(
            repeat: true,
            duration: const Duration(seconds: 2),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: KColors.chartBlue.withAlphaOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: KDevice.getHeight(context) * 0.1,
          right: 30,
          child: PulseAnimationWapper(
            duration: const Duration(milliseconds: 1500),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: KColors.investment.withAlphaOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

