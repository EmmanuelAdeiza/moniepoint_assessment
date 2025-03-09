import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension WidgetAnimationX on Widget {
  Widget expandFromLeft({
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.easeOutCubic,
    Duration? delay,
  }) {
    return Transform(
      alignment: Alignment.centerLeft,
      transform: Matrix4.identity(),
      child: this,
    )
        .animate(
          delay: delay ?? 0.ms,
        )
        .custom(
          duration: duration,
          curve: curve,
          builder: (context, value, child) => Transform.scale(
            alignment: Alignment.centerLeft,
            scaleX: value,
            child: child,
          ),
        );
  }

}
