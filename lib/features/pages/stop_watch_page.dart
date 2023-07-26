import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:stopwatch/features/bloc/stop_watch_cubit.dart';
import 'package:stopwatch/gen/assets.gen.dart';
import 'package:stopwatch/service_locator.dart';

import '../widgets/widgets.dart';

TextStyle textStyle = GoogleFonts.montserrat();

class StopWatchPage extends HookWidget {
  const StopWatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    return BlocProvider(
      create: (_) => getIt.get<StopwatchCubit>(instanceName: 'StopwatchCubit'),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(Assets.images.background.path),
            fit: BoxFit.fill,
          )),
          child: BlocBuilder<StopwatchCubit, StopWatchState>(
            builder: (context, state) {
              final displayTime = StopWatchTimer.getDisplayTime(state.time, hours: false, milliSecond: false);

              return !state.isRunning
                  ? const InitialWidget()
                  : Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        const Spacer(),
                        Text(tr.stopwatch, style: textStyle.copyWith(color: Colors.grey, fontSize: 16)),
                        const Spacer(),
                        StopWatchTimerWidget(displayTime: displayTime),
                        const Spacer(),
                        StopWatchActionEvents(
                          isRunning: state.isRunning,
                          scrollController: scrollController,
                        ),
                        const Spacer(),
                        LapsWidget(
                          state: state,
                          scrollController: scrollController,
                        ),
                        const Spacer(),
                      ]),
                    );
            },
          ),
        ),
      ),
    );
  }
}
