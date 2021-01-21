import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';

class TimerPainter extends CustomPainter {
  final Animation animation;
  final Color backgroundColor, color;

  TimerPainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    //generate the painter attributes
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    
    //generate the painter [shape]
    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color; //change painter color
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
