import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/effects_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/particle_system_config.dart';
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
  }) {
    final weatherMain = current.weather.first.main?.toLowerCase() ?? "";

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final isNight = now > current.sunset || now < current.sunrise;

    if (weatherMain.contains('rain') && isNight) {
      return const WeatherAnimationConfig(
        sceneType: WeatherSceneType.rainNight,
        isNight: true,
        skyGradient: SkyGradientConfig(
          colors: [
            Color(0xFF0D1B2A),
            Color(0xFF1B263B),
            Color(0xFF000000),
          ],
        ),
        shaderConfig: ShaderConfig(
          shaderType: ShaderType.stormSky,
          distortionIntensity: 0.3,
          lightningEnabled: true,
        ),
        atmosphereConfig: AtmosphereConfig(
          cloudDensity: 0.9,
          fogIntensity: 0.2,
          starsVisible: false,
          moonVisible: false,
        ),
        particleConfig: ParticleSystemConfig(
          particleType: ParticleType.rain,
          density: 0.8,
          speed: 1.5,
        ),
        effectsConfig: EffectsConfig(
          lightningEnabled: true,
          lightningFrequency: 0.4,
        ),
      );
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
      particleConfig: ParticleSystemConfig(
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
}
