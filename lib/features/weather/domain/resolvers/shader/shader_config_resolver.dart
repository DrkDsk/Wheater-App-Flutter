import 'package:clima_app/features/weather/domain/entities/sky_atmosphere_metrics.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/shader_config.dart';
import 'package:clima_app/features/weather/presentation/enums/shader_type.dart';
import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';

class ShaderConfigResolver {
  static ShaderConfig resolve(
    SkyAtmosphereMetrics metrics,
    WeatherSceneType scene,
  ) {
    final fogDensity = metrics.haze * (0.5 + metrics.rainFactor * 0.5);
    final turbulence = metrics.storminess * 0.9;
    final exposure = 0.5 + metrics.brightness * 0.5;

    return ShaderConfig(
      turbulenceIntensity: turbulence,
      animationSpeed: 0.2 + metrics.windFactor,
      windFlowIntensity: metrics.windFactor,
      fogDensity: fogDensity,
      hazeIntensity: metrics.haze,
      airDensity: (metrics.cloudFactor + metrics.haze + metrics.rainFactor) / 3,
      exposure: exposure,
      contrast: 1 + (metrics.storminess * 0.35),
      vignetteIntensity: metrics.storminess * 0.75,
      cloudShadowIntensity: metrics.cloudFactor,
      horizonGlowIntensity: metrics.solarElevation * (1 - metrics.cloudFactor),
      atmosphericNoiseOpacity: metrics.storminess * 0.1,
      coldTintStrength: metrics.storminess * 0.4,
      warmTintStrength: metrics.warmth,
      saturation: 1 - (metrics.storminess * 0.25),
      bloomIntensity: metrics.uvFactor * 0.15,
      shaderTypes: {
        if (fogDensity > 0.6) ShaderType.volumetricFog,
        if (metrics.warmth > 0.8) ShaderType.heatDistortion,
      },
    );
  }
}
