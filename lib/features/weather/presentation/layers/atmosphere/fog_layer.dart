import 'dart:ui';

import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:flutter/material.dart';

class FogLayer extends StatelessWidget {
  final AtmosphereConfig config;

  const FogLayer({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    if (config.fogIntensity <= 0) return const SizedBox.shrink();

    return IgnorePointer(
      child: RepaintBoundary(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: config.fogIntensity * 4,
            sigmaY: config.fogIntensity * 4,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  config.fogColor.customOpacity(config.fogIntensity * 0.14),
                  config.fogColor.customOpacity(config.fogIntensity * 0.22),
                ],
                stops: const [0.22, 0.7, 1],
              ),
            ),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}
