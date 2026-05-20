import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class BlizzardPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF7E919F);

  @override
  Color get topSkyB => const Color(0xFFAEBBC5);

  @override
  Color get warmA => const Color(0xFFD3D5D8);

  @override
  Color get warmB => const Color(0xFFC1C6CB);

  @override
  Color get horizonA => const Color(0xFFDCE3E8);

  @override
  Color get horizonB => const Color(0xFFF7F9FA);

  @override
  Color get radialA => const Color(0xAACFE1F0);

  @override
  Color get radialB => const Color(0x668EA9BF);
}
