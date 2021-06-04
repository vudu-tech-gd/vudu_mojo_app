import 'package:flutter/material.dart';

class Circle extends CustomPainter {
  Paint? _paint;
  final Color color;
  final double strokeWidth;
  final PaintingStyle paintingStyle;

  Circle({
    required this.color,
    required this.strokeWidth,
    required this.paintingStyle,
  }) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 5.0, _paint!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
