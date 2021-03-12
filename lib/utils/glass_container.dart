import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer(
      {Key key,
      this.width,
      this.height,
      this.boderRadius,
      this.padding,
      this.margin,
      this.boxBorder,
      this.child})
      : super(key: key);

  final double width;
  final double height;
  final BorderRadiusGeometry boderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BoxBorder boxBorder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          margin: margin,
          child: child,
          decoration: BoxDecoration(
            border: boxBorder,
            borderRadius: boderRadius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(.4),
                Colors.white.withOpacity(.3),
                Colors.white.withOpacity(.2),
                Colors.white.withOpacity(.1),
                Colors.white.withOpacity(.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
