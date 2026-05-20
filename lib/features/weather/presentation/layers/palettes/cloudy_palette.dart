import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class CloudyPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF7F97B2);

  @override
  Color get topSkyB => const Color(0xFFC7CCD1);

  @override
  Color get warmA => const Color(0xFFB5B9BD);

  @override
  Color get warmB => const Color(0xFFC7CCD1);

  @override
  Color get horizonA => const Color(0xFFC7CCD1);

  @override
  Color get horizonB => const Color(0xFFC7CCD1);

  @override
  Color get radialA => const Color(0xFFF3E7CF);

  @override
  Color get radialB => const Color(0xFFD4E1E6);
}
