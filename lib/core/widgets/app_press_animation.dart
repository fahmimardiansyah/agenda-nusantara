import 'package:flutter/material.dart';

class AppPressAnimation
    extends StatefulWidget {
  final Widget child;

  final VoidCallback onTap;

  const AppPressAnimation({
    super.key,

    required this.child,

    required this.onTap,
  });

  @override
  State<AppPressAnimation> createState() =>
      _AppPressAnimationState();
}

class _AppPressAnimationState
    extends State<AppPressAnimation> {
  double scale = 1;

  void _onTapDown(
    TapDownDetails details,
  ) {
    setState(() {
      scale = 0.96;
    });
  }

  void _onTapUp(
    TapUpDetails details,
  ) {
    setState(() {
      scale = 1;
    });

    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,

      onTapUp: _onTapUp,

      onTapCancel: _onTapCancel,

      child: AnimatedScale(
        duration: const Duration(
          milliseconds: 120,
        ),

        scale: scale,

        child: widget.child,
      ),
    );
  }
}