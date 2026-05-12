import 'package:flutter/material.dart';

class AppPageTransition<T>
    extends PageRouteBuilder<T> {
  final Widget page;

  AppPageTransition({
    required this.page,
  }) : super(
          transitionDuration:
              const Duration(
            milliseconds: 450,
          ),

          reverseTransitionDuration:
              const Duration(
            milliseconds: 350,
          ),

          pageBuilder:
              (
                context,
                animation,
                secondaryAnimation,
              ) =>
                  page,

          transitionsBuilder:
              (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
            const begin = Offset(
              0,
              0.08,
            );

            const end = Offset.zero;

            const curve =
                Curves.easeOutCubic;

            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(
              CurveTween(
                curve: curve,
              ),
            );

            return FadeTransition(
              opacity: animation,

              child: SlideTransition(
                position:
                    animation.drive(
                  tween,
                ),

                child: child,
              ),
            );
          },
        );
}