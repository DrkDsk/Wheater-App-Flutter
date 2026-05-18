import 'package:flutter/material.dart';

class SkyGradientConfig {
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  const SkyGradientConfig({
    required this.colors,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
  });
}
