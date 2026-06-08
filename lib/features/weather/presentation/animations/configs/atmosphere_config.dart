import 'package:flutter/material.dart';

class AtmosphereConfig {
  final double cloudCoverage;
  final double cloudDensity;
  final double fogIntensity;
  final double cloudOpacity;
  final double cloudSpeed;
  final double cloudScale;
  final double cloudSoftness;
  final Color fogColor;
  final double fogDensity;

  const AtmosphereConfig({
    required this.cloudDensity,
    required this.fogIntensity,
    this.cloudOpacity = 0.65,
    this.cloudCoverage = 1,
    this.cloudSpeed = 1,
    this.cloudScale = 1,
    this.cloudSoftness = 1,
    this.fogDensity = 1,
    this.fogColor = const Color(0xFFEAF3FF),
  });
}
