import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class MistPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF7E92A2);

  @override
  Color get topSkyB => const Color(0xFFAFBCC7);

  @override
  Color get warmA => const Color(0xFF99A5AF);

  @override
  Color get warmB => const Color(0xFFC4C0BC);

  @override
  Color get horizonA => const Color(0xFFD3DBE2);

  @override
  Color get horizonB => const Color(0xFFF0F3F5);

  @override
  Color get radialA => const Color(0x88E2EDF7);

  @override
  Color get radialB => const Color(0x44B7C8D8);
}
