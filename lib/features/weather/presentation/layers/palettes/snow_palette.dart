import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class SnowPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF9FB4C7);

  @override
  Color get topSkyB => const Color(0xFFC7D5E2);

  @override
  Color get warmA => const Color(0xFFE6E4E1);

  @override
  Color get warmB => const Color(0xFFD5D7DA);

  @override
  Color get horizonA => const Color(0xFFD8E0E7);

  @override
  Color get horizonB => const Color(0xFFF2F5F7);

  @override
  Color get radialA => const Color(0x99EAF3FB);

  @override
  Color get radialB => const Color(0x55BDD3E7);
}
