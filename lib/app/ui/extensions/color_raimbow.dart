import 'package:flutter/material.dart';

import '../ui.dart';

extension RainbowTextExtension on TextWithPadding {
  Widget withAnimatedRainbowEffect({required Animation<double> animation}) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Colors.red,
                Colors.green,
                Colors.indigo,
                Colors.blue,
                Colors.orange,
                Colors.yellow,
                Colors.purple,
              ],
              stops: const [
                0.0,
                0.16,
                0.32,
                0.48,
                0.64,
                0.8,
                1.0,
              ],
              begin: Alignment(-1.0 + 2.0 * animation.value, 0.0),
              end: Alignment(1.0 + 2.0 * animation.value, 0.0),
              tileMode: TileMode.mirror,
            ).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          child: this,
        );
      },
    );
  }
}