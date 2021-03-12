import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff4f0c7f),
            Color(0xff3f0668),
            Color(0xff0a0b76),
          ],
          stops: [
            0,
            0.5,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 10,
        color: Color(0xaf9410b3),
        blur: 0.5,
        size: 0.59,
        speed: 1.11,
        offset: 0,
        blendMode: BlendMode.lighten,
        variation1: 0.85,
        variation2: 0.67,
        variation3: 0.2,
        rotation: 0,
      ),
    );
  }
}
