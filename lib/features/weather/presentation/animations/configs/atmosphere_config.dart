import 'package:flutter/material.dart';

class AtmosphereConfig {
  final double cloudDensity;
  final double fogIntensity;
  final double cloudOpacity;
  final double cloudScale;
  final double parallaxStrength;
  final Duration cloudDriftDuration;
  final Color fogColor;
  final String? riveCloudAsset;
  final String? riveArtboard;
  final String? riveStateMachine;

  final bool starsVisible;
  final bool moonVisible;

  const AtmosphereConfig({
    required this.cloudDensity,
    required this.fogIntensity,
    required this.starsVisible,
    required this.moonVisible,
    this.cloudOpacity = 0.65,
    this.cloudScale = 1,
    this.parallaxStrength = 1,
    this.cloudDriftDuration = const Duration(seconds: 34),
    this.fogColor = const Color(0xFFEAF3FF),
    this.riveCloudAsset,
    this.riveArtboard,
    this.riveStateMachine,
  });
}
