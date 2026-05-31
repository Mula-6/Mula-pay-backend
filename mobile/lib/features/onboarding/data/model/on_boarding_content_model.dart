import 'package:flutter/material.dart';
import 'package:mobile/gen/assets.gen.dart';

@immutable
class OnBoardingContentModel {
  final String title;
  final String descriptions;
  final String displayImage;

  const OnBoardingContentModel({
    required this.title,
    required this.descriptions,
    required this.displayImage,
  });
}

class AllOnBoardingContent {
  static final List<OnBoardingContentModel> all = [
    OnBoardingContentModel(
      title: 'Built for people who value trust',
      descriptions:
          'Manage your money with confidence using tools designed for transparency, security, and collaboration.',
      displayImage: Assets.images.pngs.onboarding3.path,
    ),
    OnBoardingContentModel(
      title: 'Make smarter financial decisions',
      descriptions:
          'Get clear insights, guided actions, and real-time support to help you stay in control of your finances.',
      displayImage: Assets.images.pngs.onboarding4.path,
    ),
    OnBoardingContentModel(
      title: 'Grow faster, stay organized',
      descriptions:
          'Track progress, manage transactions, and work smarter all from one powerful financial platform.',
      displayImage: Assets.images.pngs.onboarding5.path,
    ),
  ];
}
