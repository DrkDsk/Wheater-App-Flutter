import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class HeavyRainPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF273746);

  @override
  Color get topSkyB => const Color(0xFF425565);

  @override
  Color get warmA => const Color(0xFF6F7378);

  @override
  Color get warmB => const Color(0xFF5C6269);

  @override
  Color get horizonA => const Color(0xFF6D7B88);

  @override
  Color get horizonB => const Color(0xFF909CA5);

  @override
  Color get radialA => const Color(0x667F9FBE);

  @override
  Color get radialB => const Color(0x222D4358);
}
