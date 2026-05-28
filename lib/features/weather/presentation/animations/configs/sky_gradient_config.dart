import 'package:flutter/material.dart';

class SkyGradientConfig {
  final List<Color> colors;
  final List<double>? stops;
  final Alignment begin;
  final Alignment end;
  final Color? radialAccentColor;
  final Alignment radialAccentAlignment;
  final double radialAccentRadius;
  final Duration transitionDuration;
  final double animatedShift;

  const SkyGradientConfig({
    required this.colors,
    this.stops,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.radialAccentColor,
    this.radialAccentAlignment = Alignment.topRight,
    this.radialAccentRadius = 1,
    this.transitionDuration = const Duration(milliseconds: 1200),
    this.animatedShift = 0,
  });
}
