import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';

class WeatherSceneTypeResolver {
  static WeatherSceneType resolveWeatherSceneType({
    required int code,
    required String description,
  }) {
    final normalizedDescription = description.toLowerCase();

    // =========================================================
    // THUNDERSTORM
    // =========================================================

    if (code >= 200 && code <= 232) {
      return WeatherSceneType.thunderstorm;
    }

    // =========================================================
    // DRIZZLE
    // =========================================================

    if (code >= 300 && code <= 321) {
      return WeatherSceneType.drizzle;
    }

    // =========================================================
    // RAIN
    // =========================================================

    if (code >= 500 && code <= 531) {
      if (normalizedDescription.contains('heavy') ||
          code == 502 ||
          code == 503 ||
          code == 504 ||
          code == 522) {
        return WeatherSceneType.heavyRain;
      }

      return WeatherSceneType.rain;
    }

    // =========================================================
    // SNOW
    // =========================================================

    if (code >= 600 && code <= 622) {
      if (normalizedDescription.contains('heavy') ||
          normalizedDescription.contains('blizzard')) {
        return WeatherSceneType.blizzard;
      }

      return WeatherSceneType.snow;
    }

    // =========================================================
    // ATMOSPHERIC
    // =========================================================
    if (code >= 700 && code <= 799) {
      if (normalizedDescription.contains('fog')) {
        return WeatherSceneType.fog;
      }

      if (normalizedDescription.contains('mist')) {
        return WeatherSceneType.mist;
      }

      if (normalizedDescription.contains('haze')) {
        return WeatherSceneType.haze;
      }

      if (normalizedDescription.contains('smoke')) {
        return WeatherSceneType.smoke;
      }

      if (normalizedDescription.contains('dust') ||
          normalizedDescription.contains('sand') ||
          normalizedDescription.contains('ash')) {
        return WeatherSceneType.dust;
      }

      return WeatherSceneType.fog;
    }

    // =========================================================
    // CLEAR / CLOUDS
    // =========================================================

    if (code == 800) {
      return WeatherSceneType.clear;
    }

    if (code == 801) {
      return WeatherSceneType.fewClouds;
    }

    if (code == 802) {
      return WeatherSceneType.cloudy;
    }

    if (code == 803 || code == 804) {
      return WeatherSceneType.overcast;
    }

    return WeatherSceneType.clear;
  }
}
