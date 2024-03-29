import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stopwatch/core/constants.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/widgets/button_border.dart';
import 'package:stopwatch/service_locator.dart';

class StopWatchActionEvents extends HookWidget {
  const StopWatchActionEvents({
    Key? key,
    required ScrollController scrollController,
    required bool isRunning,
  })  : _scrollController = scrollController,
        _isRunning = isRunning,
        super(key: key);

  final ScrollController _scrollController;
  final bool _isRunning;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(initialValue: 0.0, duration: const Duration(milliseconds: 500));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
            key: const Key(addLapKey),
            onTap: () async {
              _toggle(animationController);

              getIt.get<StopwatchCubit>(instanceName: 'StopwatchCubit').addLap();
              Future.delayed(const Duration(milliseconds: 100), () {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              });
            },
            child: BorderWrap(animationController: animationController, child: const Icon(Icons.flag))),
        GestureDetector(
          key: const Key(playPauseKey),
          onTap: () {
            _toggle(animationController);
            if (_isRunning) {
              getIt.get<StopwatchCubit>(instanceName: 'StopwatchCubit').stopTimer();
            } else {
              getIt.get<StopwatchCubit>(instanceName: 'StopwatchCubit').startTimer();
            }
          },
          child: BorderWrap(
            animationController: animationController,
            child: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
          ),
        )
      ],
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
