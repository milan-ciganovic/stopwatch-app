import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stopwatch/core/constants.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/widgets/button_border.dart';
import 'package:stopwatch/service_locator.dart';

class InitialWidget extends HookWidget {
  final String displayTime;

  const InitialWidget({
    required this.displayTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(initialValue: 0.0, duration: const Duration(milliseconds: 500));

    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(tr.stopwatch, style: theme.themeData.textTheme.bodyLarge),
          Text(displayTime, style: theme.themeData.textTheme.headlineLarge),
          Text(tr.ready, style: theme.themeData.textTheme.headlineSmall),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                key: const Key(startTimerKey),
                onTap: () {
                  _toggle(animationController);
                  getIt.get<StopwatchCubit>(instanceName: 'StopwatchCubit').startTimer();
                },
                child: BorderWrap(animationController: animationController, child: const Icon(Icons.play_arrow)),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                key: const Key(resetTimerKey),
                onTap: () {
                  _toggle(animationController);

                  getIt.get<StopwatchCubit>(instanceName: 'StopwatchCubit').resetTimer();
                },
                child: BorderWrap(animationController: animationController, child: const Icon(Icons.refresh)),
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _toggle(AnimationController a) {
    if (a.value == 0.0) {
      a.forward();
    } else {
      a.reverse();
    }
  }
}
