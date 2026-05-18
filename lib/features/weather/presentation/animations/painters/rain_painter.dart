import 'dart:math';

import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class RainPainter extends CustomPainter {
  final double density;
  final double speed;

  RainPainter({
    required this.density,
    required this.speed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.customOpacity(0.4)
      ..strokeWidth = 1;

    final random = Random();

    final drops = (density * 200).toInt();

    for (int i = 0; i < drops; i++) {
      final x = random.nextDouble() * size.width;

      final y = random.nextDouble() * size.height;

      final rainLength = 10 * speed;

      canvas.drawLine(
        Offset(x, y),
        Offset(x - 2, y + rainLength),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
