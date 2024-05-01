import 'package:flutter/material.dart';

class DottedLine extends CustomPainter {
  final double width;
  final double spacing;
  final Color color;

  DottedLine({required this.width, required this.color, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    double length = 0;
    while (length < size.width) {
      canvas.drawLine(
        Offset(length, 0),
        Offset(length + spacing, 0),
        paint,
      );
      length += 2 * spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
