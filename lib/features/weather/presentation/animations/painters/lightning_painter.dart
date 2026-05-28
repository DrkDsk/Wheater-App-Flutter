import 'dart:math';

import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class LightningPainter extends CustomPainter {
  final int seed;
  final double opacity;

  const LightningPainter({
    required this.seed,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || opacity <= 0) return;

    final random = Random(seed);
    final start = Offset(
      size.width * (0.18 + random.nextDouble() * 0.64),
      size.height * 0.02,
    );
    final paint = Paint()
      ..color = Colors.white.customOpacity(opacity)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 1.4
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.6);

    final path = Path()..moveTo(start.dx, start.dy);
    var point = start;
    final segmentCount = 5 + random.nextInt(3);

    for (int i = 0; i < segmentCount; i++) {
      point = Offset(
        point.dx + (random.nextDouble() - 0.5) * size.width * 0.09,
        point.dy + size.height * (0.035 + random.nextDouble() * 0.035),
      );
      path.lineTo(point.dx, point.dy);
    }

    canvas.drawPath(path, paint);
    canvas.drawPath(
      path,
      paint
        ..color = const Color(0xFFBFD9FF).customOpacity(opacity * 0.42)
        ..strokeWidth = 5.5
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
    );
  }

  @override
  bool shouldRepaint(covariant LightningPainter oldDelegate) {
    return oldDelegate.seed != seed || oldDelegate.opacity != opacity;
  }
}
