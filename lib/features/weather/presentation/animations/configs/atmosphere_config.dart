import 'package:flutter/material.dart';

class AtmosphereConfig {
  final double cloudCoverage;
  final double cloudDensity;
  final double fogIntensity;
  final double cloudOpacity;
  final double cloudSpeed;
  final double cloudScale;
  final double parallaxStrength;
  final Duration cloudDriftDuration;
  final Color fogColor;

  const AtmosphereConfig({
    required this.cloudDensity,
    required this.fogIntensity,
    this.cloudOpacity = 0.65,
    this.cloudCoverage = 1,
    this.cloudSpeed = 1,
    this.cloudScale = 1,
    this.parallaxStrength = 1,
    this.cloudDriftDuration = const Duration(seconds: 34),
    this.fogColor = const Color(0xFFEAF3FF),
  });
}
