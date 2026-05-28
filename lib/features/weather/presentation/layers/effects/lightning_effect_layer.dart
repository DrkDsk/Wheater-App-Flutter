import 'dart:async';
import 'dart:math';

import 'package:clima_app/features/weather/presentation/animations/configs/effects_config.dart';
import 'package:clima_app/features/weather/presentation/animations/painters/lightning_painter.dart';
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
  final Random _random = Random();
  Timer? timer;
  double opacity = 0;
  int boltSeed = 0;

  @override
  void initState() {
    super.initState();

    startLightningLoop();
  }

  void startLightningLoop() {
    timer = Timer.periodic(
      const Duration(milliseconds: 2600),
      (_) {
        final shouldFlash =
            _random.nextDouble() < widget.config.lightningFrequency;

        if (!shouldFlash) return;

        setState(() {
          boltSeed = _random.nextInt(100000);
          opacity = 1;
        });

        Future.delayed(
          widget.config.flashDuration,
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
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOutCubic,
        opacity: opacity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withAlpha(
                      (widget.config.flashOpacity * 255).round(),
                    ),
                    Colors.white.withAlpha(
                      (widget.config.flashOpacity * 72).round(),
                    ),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            CustomPaint(
              painter: LightningPainter(
                seed: boltSeed,
                opacity: widget.config.boltOpacity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
