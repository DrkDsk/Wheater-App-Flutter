import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class ClearSkyPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF4DA6FF);

  @override
  Color get topSkyB => const Color(0xFF9ED0FF);

  @override
  Color get warmA => const Color(0xFFFFE4A3);

  @override
  Color get warmB => const Color(0xFFFFB74D);

  @override
  Color get horizonA => const Color(0xFFD8DDE3);

  @override
  Color get horizonB => const Color(0xFFF8FBFF);

  @override
  Color get radialA => const Color(0xFFFFF3D1);

  @override
  Color get radialB => const Color(0xFFFFC46B);
}
