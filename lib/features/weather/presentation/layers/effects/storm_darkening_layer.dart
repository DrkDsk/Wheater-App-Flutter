import 'package:clima_app/features/weather/presentation/animations/configs/effects_config.dart';
import 'package:flutter/material.dart';

class StormDarkeningLayer extends StatelessWidget {
  final EffectsConfig config;

  const StormDarkeningLayer({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    if (config.darkOverlayOpacity <= 0) return const SizedBox.shrink();

    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha((config.darkOverlayOpacity * 150).round()),
              Colors.transparent,
              Colors.black.withAlpha((config.darkOverlayOpacity * 255).round()),
            ],
            stops: const [0, 0.46, 1],
          ),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}
