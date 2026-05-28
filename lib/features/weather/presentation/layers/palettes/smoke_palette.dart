import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class SmokePalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF5C6773);

  @override
  Color get topSkyB => const Color(0xFF7C8791);

  @override
  Color get warmA => const Color(0xFFB89F8A);

  @override
  Color get warmB => const Color(0xFFD2C1B2);

  @override
  Color get horizonA => const Color(0xFF8A8F95);

  @override
  Color get horizonB => const Color(0xFFB2B0AA);

  @override
  Color get radialA => const Color(0x66FFD8B0);

  @override
  Color get radialB => const Color(0x00FFD8B0);
}
