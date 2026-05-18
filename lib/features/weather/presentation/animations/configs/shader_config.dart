import 'package:clima_app/features/weather/presentation/enums/shader_type.dart';

class ShaderConfig {
  final ShaderType shaderType;
  final double distortionIntensity;
  final double vignetteIntensity;
  final double grainOpacity;
  final double cloudShadowIntensity;
  final double animationSpeed;
  final bool lightningEnabled;

  const ShaderConfig({
    required this.shaderType,
    this.distortionIntensity = 0,
    this.vignetteIntensity = 0,
    this.grainOpacity = 0,
    this.cloudShadowIntensity = 0,
    this.animationSpeed = 1,
    this.lightningEnabled = false,
  });
}
