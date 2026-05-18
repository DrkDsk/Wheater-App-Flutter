import 'package:clima_app/features/weather/presentation/animations/configs/particle_system_config.dart';
import 'package:clima_app/features/weather/presentation/animations/painters/rain_painter.dart';
import 'package:flutter/material.dart';

class RainParticleLayer extends StatelessWidget {
  final ParticleSystemConfig config;

  const RainParticleLayer({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RainPainter(
        density: config.density,
        speed: config.speed,
      ),
      size: Size.infinite,
    );
  }
}
