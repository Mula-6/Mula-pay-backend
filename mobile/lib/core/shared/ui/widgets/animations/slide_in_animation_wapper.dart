
import 'package:flutter/material.dart';

import '../../../shared.dart';

class SlideInAnimationWapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final AnimationDirection direction;
  final Duration delay;
  final Curve curve;

  const SlideInAnimationWapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.direction = AnimationDirection.bottomToTop,
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
  });

  @override
  State<SlideInAnimationWapper> createState() => _SlideInAnimationWapperState();
}

class _SlideInAnimationWapperState extends State<SlideInAnimationWapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    final offset = _getOffsetByDirection(widget.direction);
    
    _animation = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  Offset _getOffsetByDirection(AnimationDirection direction) {
    switch (direction) {
      case AnimationDirection.topToBottom:
        return const Offset(0, -1);
      case AnimationDirection.bottomToTop:
        return const Offset(0, 1);
      case AnimationDirection.leftToRight:
        return const Offset(-1, 0);
      case AnimationDirection.rightToLeft:
        return const Offset(1, 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}