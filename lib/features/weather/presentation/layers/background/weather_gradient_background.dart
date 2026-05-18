import 'package:clima_app/features/weather/presentation/animations/configs/sky_gradient_config.dart';
import 'package:flutter/material.dart';

class WeatherGradientBackground extends StatelessWidget {
  final SkyGradientConfig config;

  const WeatherGradientBackground({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: config.colors,
          begin: config.begin,
          end: config.end,
        ),
      ),
    );
  }
}
