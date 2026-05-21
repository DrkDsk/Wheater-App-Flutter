import 'package:clima_app/features/weather/presentation/enums/shader_type.dart';

class ShaderConfig {
  // =========================================================
  // MOTION
  // =========================================================

  final double turbulenceIntensity;
  final double animationSpeed;
  final double windFlowIntensity;

  // =========================================================
  // ATMOSPHERIC DENSITY
  // =========================================================

  final double fogDensity;
  final double hazeIntensity;
  final double airDensity;

  // =========================================================
  // LIGHT RESPONSE
  // =========================================================

  final double exposure;
  final double contrast;
  final double vignetteIntensity;

  // =========================================================
  // SKY SHAPING
  // =========================================================

  final double cloudShadowIntensity;
  final double horizonGlowIntensity;
  final double atmosphericNoiseOpacity;

  // =========================================================
  // COLOR RESPONSE
  // =========================================================

  final double coldTintStrength;
  final double warmTintStrength;
  final double saturation;

  // =========================================================
  // CINEMATIC
  // =========================================================

  final double bloomIntensity;

  // =========================================================
  // SPECIALIZED SHADERS
  // =========================================================

  final Set<ShaderType> shaderTypes;

  const ShaderConfig({
    required this.turbulenceIntensity,
    required this.animationSpeed,
    required this.windFlowIntensity,
    required this.fogDensity,
    required this.hazeIntensity,
    required this.airDensity,
    required this.exposure,
    required this.contrast,
    required this.vignetteIntensity,
    required this.cloudShadowIntensity,
    required this.horizonGlowIntensity,
    required this.atmosphericNoiseOpacity,
    required this.coldTintStrength,
    required this.warmTintStrength,
    required this.saturation,
    required this.bloomIntensity,
    required this.shaderTypes,
  });
}
