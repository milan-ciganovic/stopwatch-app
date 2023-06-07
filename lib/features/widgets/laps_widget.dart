import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/features/pages/stop_watch_page.dart';

class LapsWidget extends StatelessWidget {
  const LapsWidget({Key? key, required this.state, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;
  final StopWatchState state;

  @override
  Widget build(BuildContext context) {
    final displayTimeMilliseconds = StopWatchTimer.getDisplayTime(state.time, hours: false, milliSecond: true);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: SizedBox(
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lap ${(state.laps.length + 1)}", style: textStyle.copyWith(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 14),
                      Text(displayTimeMilliseconds,
                          style: textStyle.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  children: List.generate(state.laps.length, (index) {
                    final displayTime = StopWatchTimer.getDisplayTime(state.laps[index], hours: false);

                    return Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lap ${(index + 1)}", style: textStyle.copyWith(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 14),
                            Text(displayTime, style: textStyle.copyWith(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
