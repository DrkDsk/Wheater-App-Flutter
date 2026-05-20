import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/blizzard_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/clear_sky_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/cloudy_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/drizzle_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/few_clouds_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/heavy_rain_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/overcast_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/rain_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/snow_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/thunder_storm_palette.dart';

class SkyPaletteResolver {
  static SkyPalette resolve(
    WeatherSceneType type,
  ) {
    switch (type) {
      case WeatherSceneType.clear:
        return ClearSkyPalette();
      case WeatherSceneType.fewClouds:
        return FewCloudsPalette();
      case WeatherSceneType.cloudy:
        return CloudyPalette();
      case WeatherSceneType.overcast:
        return OvercastPalette();
      case WeatherSceneType.drizzle:
        return DrizzlePalette();
      case WeatherSceneType.rain:
        return RainPalette();
      case WeatherSceneType.heavyRain:
        return HeavyRainPalette();
      case WeatherSceneType.thunderstorm:
        return ThunderStormPalette();
      case WeatherSceneType.snow:
        return SnowPalette();
      case WeatherSceneType.blizzard:
        return BlizzardPalette();
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
