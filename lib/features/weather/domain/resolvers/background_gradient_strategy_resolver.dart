import 'package:clima_app/features/weather/domain/strategy/blizzard_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/clear_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/cloud_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/drizzle_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/dust_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/few_clouds_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/fog_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/haze_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/heavy_rain_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/mist_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/overcast_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/rain_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/smoke_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/snow_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/thunderstorm_gradient_strategy.dart';
import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';

class BackgroundGradientStrategyResolver {
  static SkyGradientStrategy resolve(WeatherSceneType type) {
    switch (type) {
      case WeatherSceneType.clear:
        return ClearGradientStrategy();
      case WeatherSceneType.fewClouds:
        return FewCloudsGradientStrategy();
      case WeatherSceneType.cloudy:
        return CloudGradientStrategy();
      case WeatherSceneType.overcast:
        return OvercastGradientStrategy();
      case WeatherSceneType.drizzle:
        return DrizzleGradientStrategy();
      case WeatherSceneType.rain:
        return RainGradientStrategy();
      case WeatherSceneType.heavyRain:
        return HeavyRainGradientStrategy();
      case WeatherSceneType.thunderstorm:
        return ThunderStormGradientStrategy();
      case WeatherSceneType.snow:
        return SnowGradientStrategy();
      case WeatherSceneType.blizzard:
        return BlizzardGradientStrategy();
      case WeatherSceneType.mist:
        return MistGradientStrategy();
      case WeatherSceneType.fog:
        return FogGradientStrategy();
      case WeatherSceneType.haze:
        return HazeGradientStrategy();
      case WeatherSceneType.smoke:
        return SmokeGradientStrategy();
      case WeatherSceneType.dust:
        return DustGradientStrategy();
    }
  }
}
