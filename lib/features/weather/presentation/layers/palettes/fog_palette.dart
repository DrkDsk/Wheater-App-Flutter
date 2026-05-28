import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class FogPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF7F909E);

  @override
  Color get topSkyB => const Color(0xFFAAB7C1);

  @override
  Color get warmA => const Color(0xFF7F909E);

  @override
  Color get warmB => const Color(0xFFC0C2C4);

  @override
  Color get horizonA => const Color(0xFFE2E7EB);

  @override
  Color get horizonB => const Color(0xFFF8FAFB);

  @override
  Color get radialA => const Color(0x99E7EEF5);

  @override
  Color get radialB => const Color(0x66B9C8D6);
}
