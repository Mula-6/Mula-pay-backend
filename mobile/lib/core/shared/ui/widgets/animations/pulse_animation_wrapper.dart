import 'package:flutter/material.dart';

class PulseAnimationWapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool repeat;

  const PulseAnimationWapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.repeat = true,
  });

  @override
  State<PulseAnimationWapper> createState() => _PulseAnimationWapperState();
}

class _PulseAnimationWapperState extends State<PulseAnimationWapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );

    if (widget.repeat) {
      _controller.repeat(reverse: true);
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Create pulse effect (0->1->0)
        double value;
        if (_animation.value < 0.5) {
          value = _animation.value * 2; // 0 to 1
        } else {
          value = (1 - _animation.value) * 2; // 1 to 0
        }
        
        final scale = 0.95 + 0.1 * value; // Scale between 0.95 and 1.05
        
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: 0.7 + 0.3 * value, // Also pulse opacity
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}