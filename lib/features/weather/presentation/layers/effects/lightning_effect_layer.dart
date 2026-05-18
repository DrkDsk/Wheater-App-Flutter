import 'dart:async';
import 'dart:math';

import 'package:clima_app/features/weather/presentation/animations/configs/effects_config.dart';
import 'package:flutter/material.dart';

class LightningEffectLayer extends StatefulWidget {
  final EffectsConfig config;

  const LightningEffectLayer({
    super.key,
    required this.config,
  });

  @override
  State<LightningEffectLayer> createState() => _LightningEffectLayerState();
}

class _LightningEffectLayerState extends State<LightningEffectLayer> {
  double opacity = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    startLightningLoop();
  }

  void startLightningLoop() {
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        final random = Random();

        final shouldFlash =
            random.nextDouble() < widget.config.lightningFrequency;

        if (!shouldFlash) return;

        setState(() {
          opacity = 0.8;
        });

        Future.delayed(
          const Duration(milliseconds: 120),
          () {
            if (!mounted) return;

            setState(() {
              opacity = 0;
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 80),
        opacity: opacity,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
