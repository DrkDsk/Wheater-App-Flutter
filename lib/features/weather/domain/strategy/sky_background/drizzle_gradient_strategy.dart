import 'package:clima_app/features/weather/domain/entities/sky_atmosphere_metrics.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/sky_gradient_strategy.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/sky_gradient_config.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';
import 'package:flutter/widgets.dart';

class DrizzleGradientStrategy implements SkyGradientStrategy {
  @override
  SkyGradientConfig resolve({
    required SkyPalette palette,
    required SkyAtmosphereMetrics metrics,
    required bool isNight,
  }) {
    final uvFactor = metrics.uvFactor;
    final cloudFactor = metrics.cloudFactor;
    final windFactor = metrics.windFactor;

    final solarElevation = metrics.solarElevation;
    final warmth = metrics.warmth;
    final haze = metrics.haze;
    final storminess = metrics.storminess;

    final radialOpacity = (1.0 - metrics.storminess) * 0.35;

    final topSky = Color.lerp(
      palette.topSkyA,
      palette.topSkyB,
      storminess,
    )!;

    final warmTint = Color.lerp(
      palette.warmA,
      palette.warmB,
      haze,
    )!;

    final horizon = Color.lerp(
      palette.horizonA,
      palette.horizonB,
      haze,
    )!;

    final radialAccent = Color.lerp(
      palette.radialA,
      palette.radialB,
      warmth,
    )!
        .withValues(alpha: radialOpacity);

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
          const Color(0xFF101A24),
          const Color(0xFF14202C),
          const Color(0xFF1C2C3C),
        ],
        stops: const [0.0, 0.55, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
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
      radialAccentColor: radialAccent,
      radialAccentAlignment: radialAlignment,
      radialAccentRadius: radialRadius,
      transitionDuration: transitionDuration,
      animatedShift: animatedShift,
    );
  }
}
