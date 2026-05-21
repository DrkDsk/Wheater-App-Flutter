import 'package:clima_app/features/weather/domain/strategy/sky_background/blizzard_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/clear_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/cloud_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/drizzle_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/dust_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/few_clouds_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/fog_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/haze_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/heavy_rain_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/mist_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/overcast_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/rain_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/sky_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/smoke_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/snow_gradient_strategy.dart';
import 'package:clima_app/features/weather/domain/strategy/sky_background/thunderstorm_gradient_strategy.dart';
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
