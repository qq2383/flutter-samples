import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Dashboard extends CustomPainter {
  final double mpaMax;

  Dashboard(this.mpaMax);

  Paint p = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    draw(canvas, size);
  }

  void draw(Canvas canvas, Size size) {
    double r0 = size.width / 2;
    p.color = Colors.green;

    // canvas.save();
    canvas.translate(r0, 150);

    for (num i = 0; i <= 40; i++) {
      double r1 = r0 - 10;
      if (i % 10 == 0) {
        r1 = r0 - 24;
      } else if (i % 5 == 0) {
        r1 = r0 - 16;
      }

      num deg = (2 * pi / 360) * 4.5 * i;
      double x1 = -cos(deg) * r0;
      double y1 = -sin(deg) * r0;
      double x2 = -cos(deg) * r1;
      double y2 = -sin(deg) * r1;
      if (i / 10 >= mpaMax) {
        p.color = Colors.red;
      }
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), p);

      if (i % 5 == 0) {
        if (i == 20) {
          x2 -= 15;
          y2 += 5;
        } else if (i == 0) {
          y2 -= 10;
        } else if (i == 40) {
          y2 -= 10;
          x2 -= 30;
        } else if (i == 15) {
          x2 -= 10;
          y2 += 5;
        } else if (i == 25) {
          x2 -= 20;
        } else if (i > 20) {
          x2 -= 30;
        }

        ui.Paragraph par =
            _buildText((i / 10).toString(), 30, TextAlign.center, Colors.black);
        canvas.drawParagraph(par, Offset(x2, y2));
      }
    }

    p.color = Colors.black;
    p.style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(0, 0), 5, p);
  }

  ui.Paragraph _buildText(
      String content, double maxWidth, TextAlign align, ui.Color color) {
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: align,
    ));
    pb.pushStyle(ui.TextStyle(
      color: color,
      fontSize: 14,
    ));
    pb.addText(content);
    ui.Paragraph p = pb.build();
    p.layout(ui.ParagraphConstraints(
      width: maxWidth,
    ));
    return p;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // throw UnimplementedError();
    return true;
  }
}
