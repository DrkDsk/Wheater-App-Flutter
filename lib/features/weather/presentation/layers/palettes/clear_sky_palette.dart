import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class ClearSkyPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF4DA6FF);

  @override
  Color get topSkyB => const Color(0xFF9ED0FF);

  @override
  Color get warmA => const Color(0xFFA3DCFA);

  @override
  Color get warmB => const Color(0xFF80C1FF);

  @override
  Color get horizonA => const Color(0xE19CC8EF);

  @override
  Color get horizonB => const Color(0xFFA3C5F4);

  @override
  Color get radialA => const Color(0xFF9CC8EF);

  @override
  Color get radialB => const Color(0xFFC9E5FF);
}
