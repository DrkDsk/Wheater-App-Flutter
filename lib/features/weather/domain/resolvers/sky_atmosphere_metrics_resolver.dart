import 'dart:math';

import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/weather/domain/entities/sky_atmosphere_metrics.dart';

class SkyAtmosphereMetricsResolver {
  static SkyAtmosphereMetrics resolve(
    Current current,
    bool isNight,
  ) {
    final uvFactor = (current.uvi / 11).clamp(0.0, 1.0);

    final visibilityFactor = (current.visibility / 10000).clamp(0.0, 1.0);

    final cloudFactor = (current.clouds / 100).clamp(0.0, 1.0);

    final humidityFactor = (current.humidity / 100).clamp(0.0, 1.0);

    final pressureFactor = ((current.pressure - 980) / 50).clamp(0.0, 1.0);

    final rainMm = current.rain?.the1H ?? 0.0;

    final rainFactor = pow(
      (rainMm / 12).clamp(0.0, 1.0),
      0.6,
    ).toDouble();

    // =========================================================
    // SOLAR ELEVATION
    // =========================================================

    double solarElevation = 0;

    if (!isNight) {
      final sunrise = current.sunrise;
      final sunset = current.sunset;
      final now = current.dt;

      final dayProgress =
          ((now - sunrise) / (sunset - sunrise)).clamp(0.0, 1.0);

      solarElevation = sin(dayProgress * pi);
    }

    // =========================================================
    // METRICS
    // =========================================================

    final lightIntensity = (uvFactor * 0.65) + (solarElevation * 0.35);

    final brightness = (lightIntensity * 0.45) +
        (visibilityFactor * 0.25) +
        ((1.0 - cloudFactor) * 0.20) +
        (pressureFactor * 0.10);

    final warmth = (solarElevation * 0.5) +
        (((current.temp) / 38).clamp(0.0, 1.0) * 0.2) +
        ((1.0 - cloudFactor) * 0.3);

    final haze = ((1.0 - visibilityFactor) * 0.45) +
        (humidityFactor * 0.35) +
        (rainFactor * 0.20);

    final storminess = (cloudFactor * 0.5) +
        (rainFactor * 0.3) +
        ((1.0 - pressureFactor) * 0.2);

    return SkyAtmosphereMetrics(
      brightness: brightness,
      warmth: warmth,
      haze: haze,
      storminess: storminess,
      solarElevation: solarElevation,
    );
  }
}
