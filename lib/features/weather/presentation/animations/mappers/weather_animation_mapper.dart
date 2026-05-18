import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/effects_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/particle_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/shader_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/sky_gradient_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/weather_animation_config.dart';
import 'package:clima_app/features/weather/presentation/enums/particle_type.dart';
import 'package:clima_app/features/weather/presentation/enums/shader_type.dart';
import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';
import 'package:flutter/material.dart';

class WeatherAnimationMapper {
  static WeatherAnimationConfig map({
    required Current current,
    Daily? daily,
    DateTime? now,
  }) {
    final isNight = _isNight(
      current: current,
      now: now,
    );

    if (_isRain(current: current, daily: daily) && isNight) {
      return _rainNight(current: current, daily: daily);
    }

    return const WeatherAnimationConfig(
      sceneType: WeatherSceneType.clearDay,
      isNight: false,
      skyGradient: SkyGradientConfig(
        colors: [
          Colors.lightBlueAccent,
          Colors.blue,
        ],
      ),
      shaderConfig: ShaderConfig(
        shaderType: ShaderType.clearSky,
      ),
      atmosphereConfig: AtmosphereConfig(
        cloudDensity: 0.1,
        fogIntensity: 0,
        starsVisible: false,
        moonVisible: false,
      ),
      particleConfig: ParticleConfig(
        particleType: ParticleType.none,
        density: 0,
        speed: 0,
      ),
      effectsConfig: EffectsConfig(
        lightningEnabled: false,
        lightningFrequency: 0,
      ),
    );
  }

  static WeatherAnimationConfig _rainNight({
    required Current current,
    Daily? daily,
  }) {
    final cloudAmount = ((current.clouds ?? daily?.clouds ?? 82) / 100)
        .clamp(0.55, 1.0)
        .toDouble();
    final rainVolume =
        (current.rain?.the1H ?? daily?.rain ?? 1.2).clamp(0.4, 5.0).toDouble();
    final windSpeed = (current.windSpeed ?? daily?.windSpeed ?? 3.5)
        .clamp(0.0, 14.0)
        .toDouble();

    return WeatherAnimationConfig(
      sceneType: WeatherSceneType.rainNight,
      isNight: true,
      skyGradient: const SkyGradientConfig(
        colors: [
          Color(0xFF06111F),
          Color(0xFF0E2238),
          Color(0xFF142B42),
          Color(0xFF03070E),
        ],
        stops: [0, 0.38, 0.72, 1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        radialAccentColor: Color(0xFF496B8F),
        radialAccentAlignment: Alignment(-0.65, -0.92),
        radialAccentRadius: 1.25,
        animatedShift: 0.045,
      ),
      shaderConfig: ShaderConfig(
        shaderType: ShaderType.stormSky,
        distortionIntensity: 0.16 + (windSpeed * 0.012),
        vignetteIntensity: 0.58,
        grainOpacity: 0.055,
        cloudShadowIntensity: 0.46 + (cloudAmount * 0.22),
        animationSpeed: 0.72,
        lightningEnabled: true,
      ),
      atmosphereConfig: AtmosphereConfig(
        cloudDensity: cloudAmount,
        fogIntensity: 0.18 + (cloudAmount * 0.12),
        cloudOpacity: 0.72,
        cloudScale: 1.08,
        parallaxStrength: 0.55 + (windSpeed * 0.03),
        cloudDriftDuration: const Duration(seconds: 42),
        fogColor: const Color(0xFFDCEAFF),
        starsVisible: false,
        moonVisible: false,
      ),
      particleConfig: ParticleConfig(
        particleType: ParticleType.rain,
        density: 0.5 + (rainVolume * 0.13),
        speed: 0.95 + (rainVolume * 0.12) + (windSpeed * 0.025),
        angle: -0.22 - (windSpeed * 0.01),
        opacity: 0.62,
        strokeWidth: 1.1,
        particleLength: 18 + (rainVolume * 2.4),
        depthLayers: 3,
        seed: 1701,
        color: const Color(0xFFE8F3FF),
      ),
      effectsConfig: const EffectsConfig(
        lightningEnabled: true,
        lightningFrequency: 0.22,
        flashOpacity: 0.18,
        boltOpacity: 0.18,
        darkOverlayOpacity: 0.26,
        distortionStrength: 0.08,
        flashDuration: Duration(milliseconds: 150),
      ),
    );
  }

  static bool _isRain({
    required Current current,
    Daily? daily,
  }) {
    final currentSaysRain = current.weather.any((condition) {
      final main = condition.main?.toLowerCase() ?? '';
      final id = condition.id ?? 0;

      return main.contains('rain') ||
          main.contains('drizzle') ||
          id >= 500 && id < 600 ||
          id >= 300 && id < 400;
    });

    final dailySaysRain = daily?.weather.any((condition) {
          final main = condition.main?.toLowerCase() ?? '';
          final id = condition.id ?? 0;

          return main.contains('rain') ||
              main.contains('drizzle') ||
              id >= 500 && id < 600 ||
              id >= 300 && id < 400;
        }) ??
        false;

    return currentSaysRain ||
        dailySaysRain ||
        (current.rain?.the1H ?? 0) > 0 ||
        (daily?.rain ?? 0) > 0;
  }

  static bool _isNight({
    required Current current,
    DateTime? now,
  }) {
    final sampleEpochSeconds =
        current.dt ?? ((now ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000);

    return sampleEpochSeconds >= current.sunset ||
        sampleEpochSeconds <= current.sunrise;
  }
}
