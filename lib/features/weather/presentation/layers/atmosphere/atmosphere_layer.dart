import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:clima_app/features/weather/presentation/layers/atmosphere/cloud_shader.dart';
import 'package:flutter/material.dart';

class AtmosphereLayer extends StatelessWidget {
  final AtmosphereConfig config;

  const AtmosphereLayer({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CloudShaderWidget(config: config),
      ],
    );
  }
}
