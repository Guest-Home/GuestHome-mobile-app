

import 'dart:math';

import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  final double progress;

  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 4.0;
    double radius = (size.width / 2) - strokeWidth / 2;

    // Draw the background circle
    Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(size.center(Offset.zero), radius, backgroundPaint);

    // Draw the progress circle
    Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.white],
      ).createShader(Rect.fromCircle(center: size.center(Offset.zero), radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint whenever progress changes
  }
}