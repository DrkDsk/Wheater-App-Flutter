import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/clear_sky_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/cloudy_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/few_clouds_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/overcast_palette.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class SkyPaletteResolver {
  static SkyPalette paletteFor(
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

      default:
        return ClearSkyPalette();
    }
  }
}
