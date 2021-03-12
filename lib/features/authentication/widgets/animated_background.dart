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
            Color(0xff000000),
            Color(0xff000000),
          ],
          stops: [
            0,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 10,
        color: Color(0xff7c0fdf),
        blur: 0,
        size: 0.28,
        speed: 0.52,
        offset: 0,
        blendMode: BlendMode.lighten,
        variation1: 0.73,
        variation2: 0,
        variation3: 0.26,
        rotation: 0,
        child: PlasmaRenderer(
          type: PlasmaType.infinity,
          particles: 10,
          color: Color(0xffa81d55),
          blur: 0,
          size: 0.26,
          speed: 1,
          offset: 0,
          blendMode: BlendMode.lighten,
          variation1: 0.82,
          variation2: 0.97,
          variation3: 0.33,
          rotation: 0,
        ),
      ),
    );
  }
}
