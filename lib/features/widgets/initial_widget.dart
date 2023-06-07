import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/pages/stop_watch_page.dart';
import 'package:stopwatch/features/widgets/button_border.dart';
import 'package:stopwatch/service_locator.dart';

class InitialWidget extends HookWidget {
  const InitialWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(initialValue: 0.0, duration: const Duration(milliseconds: 500));

    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text('Stopwatch', style: textStyle.copyWith(color: Colors.grey, fontSize: 16)),
          Text('00:00', style: textStyle.copyWith(fontSize: 60, color: Colors.grey, fontWeight: FontWeight.w200)),
          Text('Ready?', style: textStyle.copyWith(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w100)),
          const Spacer(),
          TextButton(
            onPressed: () {
              _toggle(animationController);
              getIt<StopWatchCubit>().startTimer();
            },
            child: BorderWrap(animationController: animationController, child: const Icon(Icons.play_arrow, size: 40, color: Colors.white)),
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
