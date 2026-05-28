import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class HazePalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFFE1C9A7);

  @override
  Color get topSkyB => const Color(0xFFC8C2B8);

  @override
  Color get warmA => const Color(0xFFE1C9A7);

  @override
  Color get warmB => const Color(0xFFD0B79A);

  @override
  Color get horizonA => const Color(0xFFE8DDD0);

  @override
  Color get horizonB => const Color(0xFFF5EEE6);

  @override
  Color get radialA => const Color(0x88F2DFC5);

  @override
  Color get radialB => const Color(0x44D1B38A);
}
