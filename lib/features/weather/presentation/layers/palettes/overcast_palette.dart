import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class OvercastPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF7F8285);

  @override
  Color get topSkyB => const Color(0xFF8A97A3);

  @override
  Color get warmA => const Color(0xFF7F8285);

  @override
  Color get warmB => const Color(0xFF818081);

  @override
  Color get horizonA => const Color(0xFFAAAAAD);

  @override
  Color get horizonB => const Color(0xFFAAAAAD);

  @override
  Color get radialA => const Color(0xFF7F8285);

  @override
  Color get radialB => const Color(0xFFB1AFAF);
}
