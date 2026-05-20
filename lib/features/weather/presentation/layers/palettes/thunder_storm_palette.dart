import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class ThunderStormPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF25313A);

  @override
  Color get topSkyB => const Color(0xFF3B4852);

  @override
  Color get warmA => const Color(0xFF6D7074);

  @override
  Color get warmB => const Color(0xFF555A60);

  @override
  Color get horizonA => const Color(0xFF535E68);

  @override
  Color get horizonB => const Color(0xFF727A81);

  @override
  Color get radialA => const Color(0x6687A9CC);

  @override
  Color get radialB => const Color(0x2233485D);
}
