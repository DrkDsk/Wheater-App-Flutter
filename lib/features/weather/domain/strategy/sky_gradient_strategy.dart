import 'package:clima_app/features/weather/domain/entities/sky_atmosphere_metrics.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/sky_gradient_config.dart';
import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

abstract class SkyGradientStrategy {
  SkyGradientConfig resolve({
    required SkyPalette palette,
    required SkyAtmosphereMetrics metrics,
    required bool isNight,
  });
}
