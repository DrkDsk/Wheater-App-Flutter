import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class RainPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF406790);

  @override
  Color get topSkyB => const Color(0xFF506F8A);

  @override
  Color get warmA => const Color(0xFF406790);

  @override
  Color get warmB => const Color(0xFF406790);

  @override
  Color get horizonA => const Color(0xFF4B6D89);

  @override
  Color get horizonB => const Color(0xFF466B8C);

  @override
  Color get radialA => const Color(0x669DB9D8);

  @override
  Color get radialB => const Color(0x224B6B8A);
}
