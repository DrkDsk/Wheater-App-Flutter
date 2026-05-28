import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class DrizzlePalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF5E748A);

  @override
  Color get topSkyB => const Color(0xFF7F95A8);

  @override
  Color get warmA => const Color(0xFF5E748A);

  @override
  Color get warmB => const Color(0xFF5E748A);

  @override
  Color get horizonA => const Color(0xFF8E9BA7);

  @override
  Color get horizonB => const Color(0xFF788DA2);

  @override
  Color get radialA => const Color(0x66D7E6F5);

  @override
  Color get radialB => const Color(0x228FA9C4);
}
