import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:stopwatch/features/pages/stop_watch_page.dart';
import 'dart:math' as math;

import 'package:stopwatch/gen/assets.gen.dart';

class StopWatchTimerWidget extends HookWidget {
  const StopWatchTimerWidget({
    Key? key,
    required this.displayTime,
  }) : super(key: key);

  final String displayTime;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: const Duration(seconds: 2))..repeat();

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: controller.value * 2 * math.pi,
              child: child,
            );
          },
          child: Image.asset(Assets.images.dynamicCircle.path),
        ),
        Lottie.asset(Assets.images.wave, width: 385),
        Text(displayTime, style: textStyle.copyWith(fontSize: 60, color: Colors.white)),
      ],
    );
  }
}
