import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class DustPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFFC78E5B);

  @override
  Color get topSkyB => const Color(0xFFE0B98A);

  @override
  Color get warmA => const Color(0xFFFFD29B);

  @override
  Color get warmB => const Color(0xFFF4C17B);

  @override
  Color get horizonA => const Color(0xFFD6A16B);

  @override
  Color get horizonB => const Color(0xFFEBC9A2);

  @override
  Color get radialA => const Color(0x66FFE0B0);

  @override
  Color get radialB => const Color(0x00FFE0B0);
}
