import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Hands extends CustomPainter {
  double mpaCurrent ;
  Hands(this.mpaCurrent );

  Paint p = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    double r = size.width / 2;
    canvas.translate(r, 150);
    double deg = 10 * mpaCurrent * 180 / 40;
    canvas.rotate(deg * pi / 180);
    p.color = Colors.black;
    canvas.drawLine(Offset(-r, 0), const Offset(20, 0), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
