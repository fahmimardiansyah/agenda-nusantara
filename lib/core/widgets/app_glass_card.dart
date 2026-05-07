import 'dart:ui';

import 'package:flutter/material.dart';

class AppGlassCard extends StatelessWidget {
  final Widget child;

  final EdgeInsets? padding;

  final double borderRadius;

  const AppGlassCard({
    super.key,

    required this.child,

    this.padding,

    this.borderRadius = 28,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(
        borderRadius,
      ),

      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 14,
          sigmaY: 14,
        ),

        child: Container(
          padding:
              padding ??
              const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color:
                Colors.white.withOpacity(
              0.04,
            ),

            borderRadius:
                BorderRadius.circular(
              borderRadius,
            ),

            border: Border.all(
              color:
                  Colors.white.withOpacity(
                0.08,
              ),
            ),

            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(
                  0.22,
                ),

                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),

          child: child,
        ),
      ),
    );
  }
}