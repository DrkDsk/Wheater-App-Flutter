import 'dart:math';

import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class RainPainter extends CustomPainter {
  final double density;
  final double speed;
  final double progress;
  final double angle;
  final double opacity;
  final double strokeWidth;
  final double particleLength;
  final int depthLayers;
  final int seed;
  final Color color;

  const RainPainter({
    required this.density,
    required this.speed,
    required this.progress,
    required this.angle,
    required this.opacity,
    required this.strokeWidth,
    required this.particleLength,
    required this.depthLayers,
    required this.seed,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || density <= 0) return;

    final layerCount = depthLayers.clamp(1, 5);

    for (int layer = 0; layer < layerCount; layer++) {
      final random = Random(seed + layer * 97);
      final depth = 0.56 + layer * 0.28;
      final drops = (density * 120 * depth).round();
      final paint = Paint()
        ..color = color.customOpacity((opacity / depth).clamp(0.18, 0.72))
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth * depth;
      final fallDistance = size.height + particleLength * 8;
      final drift = tan(angle) * particleLength * 1.8;

      for (int i = 0; i < drops; i++) {
        final startX = random.nextDouble() * (size.width + 120) - 60;
        final startY = random.nextDouble() * fallDistance - particleLength * 4;
        final fall = (progress * fallDistance * speed * depth) % fallDistance;
        final gust = sin(progress * pi * 2 + i * 0.33) * 2.4 * depth;
        final x = startX + drift * fall / particleLength + gust;
        final y = (startY + fall) % fallDistance - particleLength * 4;
        final length = particleLength * depth;

        canvas.drawLine(
          Offset(x, y),
          Offset(x + sin(angle) * length, y + cos(angle) * length),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant RainPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.density != density ||
        oldDelegate.speed != speed ||
        oldDelegate.angle != angle ||
        oldDelegate.opacity != opacity ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.particleLength != particleLength ||
        oldDelegate.depthLayers != depthLayers ||
        oldDelegate.seed != seed ||
        oldDelegate.color != color;
  }
}
