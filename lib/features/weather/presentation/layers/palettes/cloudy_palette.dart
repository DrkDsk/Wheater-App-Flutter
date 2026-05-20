import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class CloudyPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF7F97B2);

  @override
  Color get topSkyB => const Color(0xFFB3C0CF);

  @override
  Color get warmA => const Color(0xFFE7DCC8);

  @override
  Color get warmB => const Color(0xFFD6C8B3);

  @override
  Color get horizonA => const Color(0xFFD4D9DF);

  @override
  Color get horizonB => const Color(0xFFE7EDF4);

  @override
  Color get radialA => const Color(0xFFF3E7CF);

  @override
  Color get radialB => const Color(0xFFE4D1A8);
}
