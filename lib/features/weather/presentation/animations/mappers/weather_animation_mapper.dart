import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/weather/domain/resolvers/background_gradient_strategy_resolver.dart';
import 'package:clima_app/features/weather/domain/resolvers/sky_atmosphere_metrics_resolver.dart';
import 'package:clima_app/features/weather/domain/resolvers/sky_palette_resolver.dart';
import 'package:clima_app/features/weather/domain/resolvers/weather_scene_type_resolver.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/effects_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/particle_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/shader_config.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/weather_animation_config.dart';
import 'package:clima_app/features/weather/presentation/enums/particle_type.dart';
import 'package:clima_app/features/weather/presentation/enums/shader_type.dart';

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

    final code = current.weather.firstOrNull?.id ?? 0;
    final description = current.weather.firstOrNull?.description ?? "";

    final sceneType = WeatherSceneTypeResolver.resolveWeatherSceneType(
      code: code,
      description: description,
    );

    final strategy = BackgroundGradientStrategyResolver.resolve(sceneType);
    final metrics = SkyAtmosphereMetricsResolver.resolve(current, isNight);
    final palette = SkyPaletteResolver.resolve(sceneType);

    final skyGradient = strategy.resolve(
      metrics: metrics,
      isNight: isNight,
      current: current,
      palette: palette,
    );

    return WeatherAnimationConfig(
      sceneType: sceneType,
      isNight: isNight,
      skyGradient: skyGradient,
      shaderConfig: const ShaderConfig(
        shaderType: ShaderType.clearSky,
      ),
      atmosphereConfig: const AtmosphereConfig(
        cloudDensity: 0.1,
        fogIntensity: 0,
        starsVisible: false,
        moonVisible: false,
      ),
      particleConfig: const ParticleConfig(
        particleType: ParticleType.none,
        density: 0,
        speed: 0,
      ),
      effectsConfig: const EffectsConfig(
        lightningEnabled: false,
        lightningFrequency: 0,
      ),
    );
  }

  /*static WeatherAnimationConfig _rainNight({
    required Current current,
    Daily? daily,
  }) {
    final cloudAmount = ((current.clouds) / 100).clamp(0.55, 1.0).toDouble();
    final rainVolume =
        (current.rain?.the1H ?? daily?.rain ?? 1.2).clamp(0.4, 5.0).toDouble();

    final windSpeed = (current.windSpeed).clamp(0.0, 14.0).toDouble();

    return WeatherAnimationConfig(
      sceneType: WeatherSceneType.rain,
      isNight: true,
      skyGradient: _resolveSkyBackground(current: current, isNight: true),
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
  }*/

  static bool _isNight({
    required Current current,
    DateTime? now,
  }) {
    final sampleEpochSeconds = current.dt;

    return sampleEpochSeconds >= current.sunset ||
        sampleEpochSeconds <= current.sunrise;
  }
}
