import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile/core/application/provider/provider.dart';
import 'package:mobile/core/helpers/helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/shared/shared.dart';
import '../../data/model/model.dart';
import '../widgets/widgets.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  late PageController _pageController;
  final ValueNotifier<int> _currentPageIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );

    // Pulse animation
    _pulseAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Rotate animation
    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159, // Full rotation
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _pageController = PageController(initialPage: _currentPageIndex.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPageIndex.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void nextSlide() {
    if (_currentPageIndex.value < AllOnBoardingContent.all.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void toNextPage() async {
    await ref.read(appAuthStateProvider.notifier).setHasOnBoarded();
  }

  void prevSlide() {
    if (_currentPageIndex.value > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedCircleBubbleWidgets(
            scaleAnimation: _scaleAnimation,
            pulseAnimation: _pulseAnimation,
            rotateAnimation: _rotateAnimation,
          ),

          Positioned(
            top: KDevice.getHeight(context) * 0.05,
            right: 10,
            child: InkWell(
              onTap: toNextPage,
              child: Text(
                "Skip",
                style: KTextStyles.bodyLarge(
                  context,
                ).copyWith(color: KColors.backgroundLight),
              ),
            ),
          ),
          Positioned(
            right: 10,
            left: 10,
            top: KDevice.getHeight(context) * 0.2,
            child: SizedBox(
              height: KDevice.getHeight(context) * 0.45,
              child: PageView.builder(
                physics: BouncingScrollPhysics(),

                controller: _pageController,
                onPageChanged: (value) {
                  _currentPageIndex.value = value;
                },
                itemCount: AllOnBoardingContent.all.length,
                itemBuilder: (context, index) {
                  var current = AllOnBoardingContent.all[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInAnimationWarpper(
                        duration: const Duration(milliseconds: 1000),
                        child: SizedBox(
                          child: Image.asset(
                            current.displayImage,
                            height: KDevice.getHeight(context) * 0.3,
                          ),
                        ),
                      ),

                      Spacer(),
                      SlideInAnimationWapper(
                        delay: Duration(milliseconds: 800),
                        child: Text(
                          current.title,
                          style: KTextStyles.titleLarge(context).copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SlideInAnimationWapper(
                        delay: Duration(milliseconds: 800),
                        child: Text(current.descriptions),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          Positioned(
            left: 10,
            right: 10,
            top: KDevice.getHeight(context) * 0.85,
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(
                horizontal: KSize.symmetricHorizontal,
              ),

              child: ValueListenableBuilder(
                valueListenable: _currentPageIndex,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (value != 0)
                        if (value != AllOnBoardingContent.all.length - 1)
                          FadeInAnimationWarpper(
                            child: NavigateSlideWidgets(
                              onclick: prevSlide,
                              icon: HugeIcons.strokeRoundedArrowLeft01,
                            ),
                          ),
                      FadeInAnimationWarpper(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          effect: WormEffect(
                            radius: 6,
                            dotHeight: 6,
                            dotColor: Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlphaOpacity(0.3),
                            activeDotColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            dotWidth: 16,
                          ),

                          count: AllOnBoardingContent.all.length,
                        ),
                      ),

                      if (value != AllOnBoardingContent.all.length - 1)
                        FadeInAnimationWarpper(
                          child: NavigateSlideWidgets(
                            onclick: nextSlide,
                            icon: HugeIcons.strokeRoundedArrowRight01,
                          ),
                        ),
                      if (value == AllOnBoardingContent.all.length - 1)
                        SlideInAnimationWapper(
                          duration: Duration(milliseconds: 300),

                          child: DefaultButton(
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedArrowRight01,
                            ),
                            text: "Get Started",
                            onPressed: toNextPage,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: KDevice.getHeight(context) * 0.1,
            left: 20,
            child: BounceAnimationWarpper(
              repeat: true,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: KColors.primary.withAlphaOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: KDevice.getHeight(context) * 0.3,
            right: 20,
            child: PulseAnimationWapper(
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: KColors.chartBlue.withAlphaOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
