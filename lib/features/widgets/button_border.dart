import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BorderWrap extends HookWidget {
  final Widget child;
  final AnimationController animationController;

  const BorderWrap({Key? key, required this.child, required this.animationController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return CircularProgressIndicator(
                  value: animationController.value == 0.0 ? 1.0 : animationController.value,
                  color: animationController.value >= 0.5 ? const Color(0xffAD4772) : const Color(0xff3e1ccf),
                  strokeWidth: 2.0,
                );
              }),
        ),
        child
      ],
    );
  }
}
