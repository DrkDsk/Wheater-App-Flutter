import 'package:clima_app/features/weather/domain/strategy/clear_sky_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/cloud_sky_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_gradient_strategy.dart';
import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';

class BackgroundGradientStrategyResolver {
  static SkyGradientStrategy resolve(WeatherSceneType type) {
    switch (type) {
      case WeatherSceneType.clear:
        return ClearSkyGradientStrategy();
      case WeatherSceneType.fewClouds:
        return CloudSkyGradientStrategy();
      case WeatherSceneType.cloudy:
        return CloudSkyGradientStrategy();
      case WeatherSceneType.overcast:
        throw UnimplementedError();
      case WeatherSceneType.drizzle:
        throw UnimplementedError();
      case WeatherSceneType.rain:
        throw UnimplementedError();
      case WeatherSceneType.heavyRain:
        throw UnimplementedError();
      case WeatherSceneType.thunderstorm:
        throw UnimplementedError();
      case WeatherSceneType.snow:
        throw UnimplementedError();
      case WeatherSceneType.blizzard:
        throw UnimplementedError();
      case WeatherSceneType.mist:
        throw UnimplementedError();
      case WeatherSceneType.fog:
        throw UnimplementedError();
      case WeatherSceneType.haze:
        throw UnimplementedError();
      case WeatherSceneType.smoke:
        throw UnimplementedError();
      case WeatherSceneType.dust:
        throw UnimplementedError();
    }
  }
}
