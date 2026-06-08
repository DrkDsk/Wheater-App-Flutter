import 'package:clima_app/features/weather/domain/entities/sky_atmosphere_metrics.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';

class AtmosphereConfigResolver {
  static const double _clearScale = 0.78;
  static const double _fewCloudsScale = 0.9;
  static const double _cloudyScale = 0.62;
  static const double _overcastScale = 0.48;
  static const double _stormScale = 0.44;
  static const double _atmosphericScale = 0.72;

  static AtmosphereConfig resolve(
    SkyAtmosphereMetrics metrics,
    WeatherSceneType scene,
  ) {
    final cloudiness = _ease(metrics.cloudFactor);
    final humidity = _ease((metrics.haze + metrics.rainFactor) * 0.5);
    final wind = _ease(metrics.windFactor);
    final storm = _ease(metrics.storminess);

    return AtmosphereConfig(
      cloudCoverage: _clamp01(
        _mix(0.06, 0.92, cloudiness) + _sceneCoverageBias(scene),
      ),
      cloudDensity: _clamp01(
        _mix(0.18, 0.88, (cloudiness * 0.72) + (humidity * 0.28)) +
            _sceneDensityBias(scene),
      ),
      cloudOpacity: _clamp01(_mix(0.12, 0.72, cloudiness) + (storm * 0.08)),
      cloudSpeed: _clamp01(_mix(0.08, 0.72, wind)),
      cloudScale: _sceneScale(scene),
      cloudSoftness: _clamp01(_mix(0.58, 0.96, humidity)),
    );
  }

  static double _sceneCoverageBias(WeatherSceneType scene) {
    switch (scene) {
      case WeatherSceneType.clear:
        return -0.04;
      case WeatherSceneType.fewClouds:
        return 0.04;
      case WeatherSceneType.cloudy:
        return 0.12;
      case WeatherSceneType.overcast:
      case WeatherSceneType.thunderstorm:
        return 0.18;
      case WeatherSceneType.drizzle:
      case WeatherSceneType.rain:
      case WeatherSceneType.heavyRain:
      case WeatherSceneType.snow:
      case WeatherSceneType.blizzard:
      case WeatherSceneType.mist:
      case WeatherSceneType.fog:
      case WeatherSceneType.haze:
      case WeatherSceneType.smoke:
      case WeatherSceneType.dust:
        return 0.08;
    }
  }

  static double _sceneDensityBias(WeatherSceneType scene) {
    switch (scene) {
      case WeatherSceneType.clear:
        return -0.08;
      case WeatherSceneType.fewClouds:
        return -0.02;
      case WeatherSceneType.cloudy:
        return 0.06;
      case WeatherSceneType.overcast:
      case WeatherSceneType.thunderstorm:
        return 0.12;
      case WeatherSceneType.drizzle:
      case WeatherSceneType.rain:
      case WeatherSceneType.heavyRain:
      case WeatherSceneType.snow:
      case WeatherSceneType.blizzard:
      case WeatherSceneType.mist:
      case WeatherSceneType.fog:
      case WeatherSceneType.haze:
      case WeatherSceneType.smoke:
      case WeatherSceneType.dust:
        return 0.04;
    }
  }

  static double _sceneScale(WeatherSceneType scene) {
    switch (scene) {
      case WeatherSceneType.clear:
        return _clearScale;
      case WeatherSceneType.fewClouds:
        return _fewCloudsScale;
      case WeatherSceneType.cloudy:
        return _cloudyScale;
      case WeatherSceneType.overcast:
        return _overcastScale;
      case WeatherSceneType.thunderstorm:
      case WeatherSceneType.heavyRain:
      case WeatherSceneType.blizzard:
        return _stormScale;
      case WeatherSceneType.drizzle:
      case WeatherSceneType.rain:
      case WeatherSceneType.snow:
      case WeatherSceneType.mist:
      case WeatherSceneType.fog:
      case WeatherSceneType.haze:
      case WeatherSceneType.smoke:
      case WeatherSceneType.dust:
        return _atmosphericScale;
    }
  }

  static double _ease(double value) {
    final t = _clamp01(value);
    return t * t * (3 - (2 * t));
  }

  static double _mix(double start, double end, double amount) {
    final t = _clamp01(amount);
    return start + ((end - start) * t);
  }

  static double _clamp01(double value) => value.clamp(0.0, 1.0);
}
