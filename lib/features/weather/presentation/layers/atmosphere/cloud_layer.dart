import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:flutter/material.dart';

class CloudLayer extends StatelessWidget {
  final AtmosphereConfig config;

  const CloudLayer({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: config.cloudDensity,
        child: const Stack(
          children: [
            /// ☁️ CLOUD 1
            Positioned(
              top: 120,
              left: -40,
              child: _Cloud(
                width: 220,
              ),
            ),

            /// ☁️ CLOUD 2
            Positioned(
              top: 260,
              right: -30,
              child: _Cloud(
                width: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Cloud extends StatelessWidget {
  final double width;

  const _Cloud({
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * 0.5,
      decoration: BoxDecoration(
        color: Colors.white.customOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
