import 'package:flutter/material.dart';

/// Animation types available
enum AnimationType {
  fadeIn,
  fadeOut,
  slideIn,
  slideOut,
  scaleIn,
  scaleOut,
  bounce,
  rotate,
  pulse,
  pop,
  shimmer,
  flip,
  custom, // For custom animations using the builder
}

/// Animation direction for slide and similar animations
enum AnimationDirection {
  topToBottom,
  bottomToTop,
  leftToRight,
  rightToLeft,
}

/// A reusable animation wrapper with enum-based animation selection
/// 
/// Usage:
/// ```dart
/// AnimationWrapper(
///   animation: AnimationType.fadeIn,
///   repeat: true,
///   repeatCount: 5,
///   child: YourWidget(),
/// )
/// 
/// // With custom animation
/// AnimationWrapper(
///   animation: AnimationType.custom,
///   builder: (context, animation, child) {
///     return Transform.scale(
///       scale: animation.value,
///       child: child,
///     );
///   },
///   child: YourWidget(),
/// )
/// ```
class AnimationWrapper extends StatefulWidget {
  final Widget child;
  final AnimationType animation;
  final Duration duration;
  final Curve curve;
  final bool repeat;
  final int? repeatCount;
  final bool autoStart;
  final VoidCallback? onAnimationComplete;
  final VoidCallback? onAnimationStart;
  final Widget Function(BuildContext context, Animation<double> animation, Widget child)? builder;
  
  // Animation-specific parameters
  final AnimationDirection direction;
  final double intensity;
  final double beginValue;
  final double endValue;
  final Offset beginOffset;
  final Offset endOffset;

  const AnimationWrapper({
    super.key,
    required this.child,
    this.animation = AnimationType.fadeIn,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.repeat = false,
    this.repeatCount,
    this.autoStart = true,
    this.onAnimationComplete,
    this.onAnimationStart,
    this.builder,
    this.direction = AnimationDirection.bottomToTop,
    this.intensity = 1.0,
    this.beginValue = 0.0,
    this.endValue = 1.0,
    this.beginOffset = Offset.zero,
    this.endOffset = Offset.zero,
  });

  @override
  State<AnimationWrapper> createState() => _AnimationWrapperState();
}

class _AnimationWrapperState extends State<AnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentRepeatCount = 0;
  bool _isReverseAnimation = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Setup tween based on animation type
    _setupAnimationTween();

    if (widget.repeat) {
      _controller.addStatusListener(_handleAnimationStatus);
    }

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  void _setupAnimationTween() {
    double begin = 0;
    double end = 1;
    
    // Adjust tween values based on animation type
    switch (widget.animation) {
      case AnimationType.fadeOut:
        begin = 1;
        end = 0;
        break;
      case AnimationType.scaleOut:
        begin = 1;
        end = widget.beginValue;
        break;
      case AnimationType.slideOut:
        begin = 0;
        end = 1;
        _isReverseAnimation = true;
        break;
      default:
        begin = widget.beginValue;
        end = widget.endValue;
        break;
    }

    _animation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _currentRepeatCount++;
      
      if (widget.repeatCount != null && _currentRepeatCount >= widget.repeatCount!) {
        _controller.removeStatusListener(_handleAnimationStatus);
        widget.onAnimationComplete?.call();
      } else if (widget.repeat) {
        if (widget.curve != Curves.linear) {
          _controller.reverse();
        } else {
          _controller.forward(from: 0);
        }
      } else {
        widget.onAnimationComplete?.call();
      }
    } else if (status == AnimationStatus.dismissed && widget.repeat) {
      _controller.forward();
    }
  }

  void _startAnimation() {
    widget.onAnimationStart?.call();
    if (widget.repeat) {
      _controller.repeat(reverse: widget.curve != Curves.linear);
    } else {
      _controller.forward();
    }
  }

  /// Manually start the animation
  void start() {
    _startAnimation();
  }

  /// Manually stop the animation
  void stop() {
    _controller.stop();
  }

  /// Reset the animation to initial state
  void reset() {
    _controller.reset();
    _currentRepeatCount = 0;
  }

  /// Restart the animation from beginning
  void restart() {
    _controller.reset();
    _currentRepeatCount = 0;
    _startAnimation();
  }

  /// Get current animation value
  double get value => _animation.value;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If custom builder is provided, use it
    if (widget.builder != null) {
      return widget.builder!(context, _animation, widget.child);
    }
    
    // Otherwise use the built-in animation based on enum
    return _buildAnimationByType(context);
  }

  Widget _buildAnimationByType(BuildContext context) {
    switch (widget.animation) {
      case AnimationType.fadeIn:
      case AnimationType.fadeOut:
        return _buildFadeAnimation();
        
      case AnimationType.slideIn:
      case AnimationType.slideOut:
        return _buildSlideAnimation();
        
      case AnimationType.scaleIn:
      case AnimationType.scaleOut:
        return _buildScaleAnimation();
        
      case AnimationType.bounce:
        return _buildBounceAnimation();
        
      case AnimationType.rotate:
        return _buildRotateAnimation();
        
      case AnimationType.pulse:
        return _buildPulseAnimation();
        
      case AnimationType.pop:
        return _buildPopAnimation();
        
      case AnimationType.shimmer:
        return _buildShimmerAnimation();
        
      case AnimationType.flip:
        return _buildFlipAnimation();
        
      case AnimationType.custom:
        return widget.child; // Custom animation requires builder
    }
  }

  Widget _buildFadeAnimation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Widget _buildSlideAnimation() {
    final offset = _getSlideOffset();
    
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double value = _animation.value;
        if (_isReverseAnimation) {
          value = 1 - value;
        }
        
        return Transform.translate(
          offset: Offset(
            offset.dx * value,
            offset.dy * value,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Offset _getSlideOffset() {
    switch (widget.direction) {
      case AnimationDirection.topToBottom:
        return const Offset(0, -50);
      case AnimationDirection.bottomToTop:
        return const Offset(0, 50);
      case AnimationDirection.leftToRight:
        return const Offset(-50, 0);
      case AnimationDirection.rightToLeft:
        return const Offset(50, 0);
    }
  }

  Widget _buildScaleAnimation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double value = _animation.value;
        if (_isReverseAnimation) {
          value = 1 - value;
        }
        
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Widget _buildBounceAnimation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Create a bounce effect using Curves.bounceOut
        final bounceAnimation = CurvedAnimation(
          parent: _animation,
          curve: Curves.bounceOut,
        );
        
        final scale = 1 + widget.intensity * (1 - bounceAnimation.value);
        
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Widget _buildRotateAnimation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final angle = _animation.value * 2 * 3.14159; // Full rotation
        
        return Transform.rotate(
          angle: angle,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Widget _buildPulseAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Create pulse effect using sine wave
        final value = (1 + widget.intensity * 0.5 * (1 + _animation.value)) / 2;
        
        return Transform.scale(
          scale: widget.beginValue + (widget.endValue - widget.beginValue) * value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Widget _buildPopAnimation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Pop effect: scale up then down
        double value;
        if (_animation.value < 0.5) {
          value = _animation.value * 2; // 0 to 1
        } else {
          value = 2 - _animation.value * 2; // 1 to 0
        }
        
        final scale = 0.8 + 0.4 * value; // Scale from 0.8 to 1.2 and back
        
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Widget _buildShimmerAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white.withAlpha(127),
                Colors.transparent,
              ],
              stops: [
                _animation.value - 0.5,
                _animation.value,
                _animation.value + 0.5,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcOver,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Widget _buildFlipAnimation() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final angle = _animation.value * 3.14159; // Half flip (180 degrees)
        
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateY(angle),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

