import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/effects_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/particle_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/shader_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/sky_gradient_config.dart';
import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';

class WeatherAnimationConfig {
  final WeatherSceneType sceneType;

  final bool isNight;

  final SkyGradientConfig skyGradient;
  final ShaderConfig shaderConfig;
  final AtmosphereConfig atmosphereConfig;
  final ParticleConfig particleConfig;
  final EffectsConfig effectsConfig;

  const WeatherAnimationConfig({
    required this.sceneType,
    required this.isNight,
    required this.skyGradient,
    required this.shaderConfig,
    required this.atmosphereConfig,
    required this.particleConfig,
    required this.effectsConfig,
  });
}
