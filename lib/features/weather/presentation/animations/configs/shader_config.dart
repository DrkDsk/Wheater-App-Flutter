import 'package:clima_app/features/weather/presentation/enums/shader_type.dart';

class ShaderConfig {
  final ShaderType shaderType;
  final double distortionIntensity;
  final bool lightningEnabled;

  const ShaderConfig({
    required this.shaderType,
    this.distortionIntensity = 0,
    this.lightningEnabled = false,
  });
}
