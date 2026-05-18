import 'package:clima_app/features/weather/presentation/enums/particle_type.dart';
import 'package:flutter/material.dart';

class ParticleSystemConfig {
  final ParticleType particleType;

  final double density;
  final double speed;
  final double angle;
  final double opacity;
  final double strokeWidth;
  final double particleLength;
  final int depthLayers;
  final int seed;
  final Color color;

  const ParticleSystemConfig({
    required this.particleType,
    required this.density,
    required this.speed,
    this.angle = 0,
    this.opacity = 1,
    this.strokeWidth = 1,
    this.particleLength = 14,
    this.depthLayers = 1,
    this.seed = 0,
    this.color = Colors.white,
  });
}
