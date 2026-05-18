import 'package:clima_app/features/weather/presentation/animations/configs/particle_system_config.dart';
import 'package:clima_app/features/weather/presentation/animations/painters/rain_painter.dart';
import 'package:flutter/material.dart';

class RainParticleLayer extends StatefulWidget {
  final ParticleSystemConfig config;

  const RainParticleLayer({
    super.key,
    required this.config,
  });

  @override
  State<RainParticleLayer> createState() => _RainParticleLayerState();
}

class _RainParticleLayerState extends State<RainParticleLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: RainPainter(
                density: widget.config.density,
                speed: widget.config.speed,
                progress: _controller.value,
                angle: widget.config.angle,
                opacity: widget.config.opacity,
                strokeWidth: widget.config.strokeWidth,
                particleLength: widget.config.particleLength,
                depthLayers: widget.config.depthLayers,
                seed: widget.config.seed,
                color: widget.config.color,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}
