import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/rain.dart';
import 'package:clima_app/features/home/domain/entities/weather_condition.dart';
import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';

class FakeCurrentWeatherBuilder {
  static Current resolve(WeatherSceneType scene) {
    switch (scene) {
      // =========================================================
      // CLEAR
      // =========================================================

      case WeatherSceneType.clear:
        return _build(
          scene: scene,
          code: 800,
          main: 'Clear',
          description: 'clear sky',
          icon: '01d',
          temp: 31,
          feelsLike: 34,
          humidity: 42,
          clouds: 0,
          uvi: 10,
          visibility: 10000,
          windSpeed: 2.5,
        );

      case WeatherSceneType.fewClouds:
        return _build(
          scene: scene,
          code: 801,
          main: 'Clouds',
          description: 'few clouds',
          icon: '02d',
          temp: 28,
          feelsLike: 30,
          humidity: 52,
          clouds: 18,
          uvi: 7,
          visibility: 10000,
          windSpeed: 3.5,
        );

      case WeatherSceneType.cloudy:
        return _build(
          scene: scene,
          code: 802,
          main: 'Clouds',
          description: 'scattered clouds',
          icon: '03d',
          temp: 24,
          feelsLike: 25,
          humidity: 66,
          clouds: 55,
          uvi: 4,
          visibility: 9000,
          windSpeed: 4.5,
        );

      case WeatherSceneType.overcast:
        return _build(
          scene: scene,
          code: 804,
          main: 'Clouds',
          description: 'overcast clouds',
          icon: '04d',
          temp: 21,
          feelsLike: 22,
          humidity: 82,
          clouds: 100,
          uvi: 1,
          visibility: 7000,
          windSpeed: 5.5,
        );

      // =========================================================
      // DRIZZLE
      // =========================================================

      case WeatherSceneType.drizzle:
        return _build(
          scene: scene,
          code: 301,
          main: 'Drizzle',
          description: 'light intensity drizzle',
          icon: '09d',
          temp: 22,
          feelsLike: 22,
          humidity: 92,
          clouds: 100,
          uvi: 0,
          visibility: 6000,
          windSpeed: 3,
          rain1h: 0.8,
        );

      // =========================================================
      // RAIN
      // =========================================================

      case WeatherSceneType.rain:
        return _build(
          scene: scene,
          code: 500,
          main: 'Rain',
          description: 'light rain',
          icon: '10d',
          temp: 20,
          feelsLike: 20,
          humidity: 96,
          clouds: 100,
          uvi: 0,
          visibility: 5000,
          windSpeed: 5.5,
          rain1h: 4,
        );

      case WeatherSceneType.heavyRain:
        return _build(
          scene: scene,
          code: 502,
          main: 'Rain',
          description: 'heavy intensity rain',
          icon: '10d',
          temp: 18,
          feelsLike: 18,
          humidity: 100,
          clouds: 100,
          uvi: 0,
          visibility: 2500,
          windSpeed: 10,
          windGust: 16,
          rain1h: 18,
        );

      // =========================================================
      // THUNDERSTORM
      // =========================================================

      case WeatherSceneType.thunderstorm:
        return _build(
          scene: scene,
          code: 211,
          main: 'Thunderstorm',
          description: 'thunderstorm',
          icon: '11d',
          temp: 19,
          feelsLike: 19,
          humidity: 100,
          clouds: 100,
          uvi: 0,
          visibility: 2000,
          windSpeed: 12,
          windGust: 22,
          rain1h: 14,
        );

      // =========================================================
      // SNOW
      // =========================================================

      case WeatherSceneType.snow:
        return _build(
          scene: scene,
          code: 600,
          main: 'Snow',
          description: 'light snow',
          icon: '13d',
          temp: -2,
          feelsLike: -6,
          humidity: 90,
          clouds: 100,
          uvi: 0,
          visibility: 3000,
          windSpeed: 4,
        );

      case WeatherSceneType.blizzard:
        return _build(
          scene: scene,
          code: 601,
          main: 'Snow',
          description: 'heavy snow',
          icon: '13d',
          temp: -8,
          feelsLike: -16,
          humidity: 100,
          clouds: 100,
          uvi: 0,
          visibility: 500,
          windSpeed: 18,
          windGust: 28,
        );

      // =========================================================
      // ATMOSPHERIC
      // =========================================================

      case WeatherSceneType.mist:
        return _build(
          scene: scene,
          code: 701,
          main: 'Mist',
          description: 'mist',
          icon: '50d',
          temp: 18,
          feelsLike: 18,
          humidity: 95,
          clouds: 75,
          uvi: 1,
          visibility: 4000,
          windSpeed: 1.2,
        );

      case WeatherSceneType.fog:
        return _build(
          scene: scene,
          code: 741,
          main: 'Fog',
          description: 'fog',
          icon: '50d',
          temp: 16,
          feelsLike: 16,
          humidity: 100,
          clouds: 90,
          uvi: 0,
          visibility: 800,
          windSpeed: 0.8,
        );

      case WeatherSceneType.haze:
        return _build(
          scene: scene,
          code: 721,
          main: 'Haze',
          description: 'haze',
          icon: '50d',
          temp: 27,
          feelsLike: 29,
          humidity: 60,
          clouds: 40,
          uvi: 5,
          visibility: 5000,
          windSpeed: 2.5,
        );

      case WeatherSceneType.smoke:
        return _build(
          scene: scene,
          code: 711,
          main: 'Smoke',
          description: 'smoke',
          icon: '50d',
          temp: 29,
          feelsLike: 31,
          humidity: 55,
          clouds: 35,
          uvi: 4,
          visibility: 3500,
          windSpeed: 1.5,
        );

      case WeatherSceneType.dust:
        return _build(
          scene: scene,
          code: 761,
          main: 'Dust',
          description: 'dust',
          icon: '50d',
          temp: 33,
          feelsLike: 36,
          humidity: 25,
          clouds: 20,
          uvi: 11,
          visibility: 3000,
          windSpeed: 7.5,
        );
    }
  }

  static Current _build({
    required WeatherSceneType scene,
    required int code,
    required String main,
    required String description,
    required String icon,
    required double temp,
    required double feelsLike,
    required int humidity,
    required int clouds,
    required double uvi,
    required int visibility,
    required double windSpeed,
    double? rain1h,
    double? windGust,
  }) {
    final now = DateTime.now();

    return Current(
      dt: now.millisecondsSinceEpoch ~/ 1000,
      sunrise: DateTime(
            now.year,
            now.month,
            now.day,
            6,
            15,
          ).millisecondsSinceEpoch ~/
          1000,
      sunset: DateTime(
            now.year,
            now.month,
            now.day,
            18,
            40,
          ).millisecondsSinceEpoch ~/
          1000,
      temp: temp,
      feelsLike: feelsLike,
      pressure: _resolvePressure(scene),
      humidity: humidity,
      dewPoint: _resolveDewPoint(temp, humidity),
      uvi: uvi,
      clouds: clouds,
      visibility: visibility,
      windSpeed: windSpeed,
      windDeg: 180,
      windGust: windGust,
      weather: [
        WeatherCondition(
          id: code,
          main: main,
          description: description,
          icon: icon,
        ),
      ],
      rain: rain1h != null
          ? Rain(
              the1H: rain1h,
            )
          : null,
    );
  }

  static int _resolvePressure(WeatherSceneType scene) {
    switch (scene) {
      case WeatherSceneType.thunderstorm:
      case WeatherSceneType.heavyRain:
        return 998;

      case WeatherSceneType.overcast:
      case WeatherSceneType.rain:
      case WeatherSceneType.drizzle:
        return 1005;

      case WeatherSceneType.clear:
        return 1018;

      default:
        return 1013;
    }
  }

  static double _resolveDewPoint(
    double temp,
    int humidity,
  ) {
    final factor = humidity / 100;
    return temp - ((1 - factor) * 12);
  }
}
