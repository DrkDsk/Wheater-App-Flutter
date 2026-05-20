import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class FewCloudsPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF6FB7F5);

  @override
  Color get topSkyB => const Color(0xFFAED7F7);

  @override
  Color get warmA => const Color(0xFFFFE7B8);

  @override
  Color get warmB => const Color(0xFFFFC978);

  @override
  Color get horizonA => const Color(0xFFE4EAF0);

  @override
  Color get horizonB => const Color(0xFFF7FAFD);

  @override
  Color get radialA => const Color(0xFFFFF1D8);

  @override
  Color get radialB => const Color(0xFFFFD28A);
}
