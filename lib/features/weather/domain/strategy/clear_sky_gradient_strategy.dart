import 'dart:math';

import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/weather/domain/entities/sky_atmosphere_metrics.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_gradient_strategy.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/sky_gradient_config.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';
import 'package:flutter/widgets.dart';

class ClearSkyGradientStrategy implements SkyGradientStrategy {
  @override
  SkyGradientConfig resolve({
    required SkyPalette palette,
    required SkyAtmosphereMetrics metrics,
    required Current current,
    required bool isNight,
  }) {
    final uvFactor = (current.uvi / 11).clamp(0.0, 1.0);
    final cloudFactor = (current.clouds / 100).clamp(0.0, 1.0);
    final windFactor = (current.windSpeed / 20).clamp(0.0, 1.0);
    final rainMm = current.rain?.the1H ?? 0.0;

    final rainFactor = pow(
      (rainMm / 12).clamp(0.0, 1.0),
      0.6,
    ).toDouble();

    final solarElevation = metrics.solarElevation;
    final brightness = metrics.brightness;
    final warmth = metrics.warmth;
    final storminess = metrics.storminess;

    final lightIntensity = (uvFactor * 0.65) + (solarElevation * 0.35);
    final radialOpacity = (lightIntensity * (1.0 - rainFactor)).clamp(0.0, 1.0);

    final topSky = Color.lerp(
      palette.topSkyA,
      palette.topSkyB,
      brightness,
    )!;

    final warmTint = Color.lerp(
      palette.warmA,
      palette.warmB,
      warmth,
    )!;

    final horizon = Color.lerp(
      palette.horizonA,
      palette.horizonB,
      brightness,
    )!;

    final radialAccentColor = Color.lerp(
      palette.radialA,
      palette.radialB,
      metrics.warmth,
    )!
        .withValues(
      alpha: (1 - metrics.haze) * 0.95,
    );

    final sunY = -1.0 + ((1.0 - solarElevation) * 1.4);
    final radialAlignment = Alignment(0, sunY);
    final radialRadius = 0.45 + (solarElevation * 0.25);

    final animatedShift =
        0.02 + (uvFactor * 0.015) + (windFactor * 0.03) + (cloudFactor * 0.015);

    final transitionDuration = Duration(
      milliseconds: (1800 - (storminess * 700)).round(),
    );

    if (isNight) {
      return SkyGradientConfig(
        colors: [
          const Color(0xFF07111F),
          const Color(0xFF132238),
          const Color(0xFF1D2E48),
        ],
        stops: const [0.0, 0.55, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        radialAccentColor: cloudFactor < 0.45
            ? const Color(0xFFB7C7FF).withValues(alpha: 0.16)
            : null,
        radialAccentAlignment: const Alignment(0.4, -0.8),
        radialAccentRadius: 0.55,
        transitionDuration: transitionDuration,
        animatedShift: animatedShift * 0.45,
      );
    }

    return SkyGradientConfig(
      colors: [
        topSky,
        warmTint,
        horizon,
      ],
      stops: const [0.0, 0.52, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      radialAccentColor: radialOpacity > 0.08 ? radialAccentColor : null,
      radialAccentAlignment: radialAlignment,
      radialAccentRadius: radialRadius,
      transitionDuration: transitionDuration,
      animatedShift: animatedShift,
    );
  }
}
