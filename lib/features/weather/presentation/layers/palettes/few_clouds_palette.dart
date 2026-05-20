import 'dart:ui';

import 'package:clima_app/features/weather/presentation/layers/palettes/sky_palette.dart';

class FewCloudsPalette extends SkyPalette {
  @override
  Color get topSkyA => const Color(0xFF67AFFB);

  @override
  Color get topSkyB => const Color(0xFF9BC6ED);

  @override
  Color get warmA => const Color(0xFF71A5BD);

  @override
  Color get warmB => const Color(0xFFB8DDF0);

  @override
  Color get horizonA => const Color(0xFFABC0D1);

  @override
  Color get horizonB => const Color(0xFFB6DDFF);

  @override
  Color get radialA => const Color(0xFF7FB8DC);

  @override
  Color get radialB => const Color(0xFF95D6F8);
}
