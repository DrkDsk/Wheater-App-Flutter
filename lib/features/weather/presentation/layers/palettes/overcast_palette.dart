import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class OvercastPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF5F6E7A);

  @override
  Color get topSkyB => const Color(0xFF8A97A3);

  @override
  Color get warmA => const Color(0xFFD9D3CB);

  @override
  Color get warmB => const Color(0xFFC5BEB6);

  @override
  Color get horizonA => const Color(0xFFC4CBD2);

  @override
  Color get horizonB => const Color(0xFFD8DDE3);

  @override
  Color get radialA => const Color(0xFFEAE3D7);

  @override
  Color get radialB => const Color(0xFFD8CCBA);
}
