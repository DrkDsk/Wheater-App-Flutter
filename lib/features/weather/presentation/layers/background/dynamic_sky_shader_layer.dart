import 'dart:math' as math;
import 'dart:ui' show PointMode;

import 'package:clima_app/features/weather/presentation/animations/configs/shader_config.dart';
import 'package:flutter/material.dart';

class DynamicSkyShaderLayer extends StatefulWidget {
  final ShaderConfig config;

  const DynamicSkyShaderLayer({
    super.key,
    required this.config,
  });

  @override
  State<DynamicSkyShaderLayer> createState() => _DynamicSkyShaderLayerState();
}

class _DynamicSkyShaderLayerState extends State<DynamicSkyShaderLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
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
              painter: _StormSkyShaderPainter(
                config: widget.config,
                progress: _controller.value,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class _StormSkyShaderPainter extends CustomPainter {
  final ShaderConfig config;
  final double progress;

  const _StormSkyShaderPainter({
    required this.config,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final time = progress * math.pi * 2 * config.animationSpeed;
    final drift = math.sin(time) * size.width * 0.08;

    _paintCloudShadow(canvas, size, drift);
    _paintAtmosphericSheen(canvas, size, time);
    _paintVignette(canvas, size);
    _paintGrain(canvas, size);
  }

  void _paintCloudShadow(Canvas canvas, Size size, double drift) {
    final paint = Paint()
      ..blendMode = BlendMode.multiply
      ..shader = RadialGradient(
        center: Alignment(-0.45 + drift / size.width, -0.78),
        radius: 1.25,
        colors: [
          Color.fromARGB(
            (config.cloudShadowIntensity * 92).round(),
            0,
            0,
            0,
          ),
          Colors.transparent,
        ],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, paint);
  }

  void _paintAtmosphericSheen(Canvas canvas, Size size, double time) {
    final bend = math.sin(time * 0.7) * config.distortionIntensity;
    final paint = Paint()
      ..blendMode = BlendMode.screen
      ..shader = LinearGradient(
        begin: Alignment(-1 + bend, -1),
        end: Alignment(0.9 + bend, 0.75),
        colors: const [
          Color(0x001B4268),
          Color(0x244C7195),
          Color(0x0015223A),
        ],
        stops: const [0.18, 0.48, 1],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, paint);
  }

  void _paintVignette(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        radius: 0.96,
        colors: [
          Colors.transparent,
          Color.fromARGB(
            (config.vignetteIntensity * 190).round(),
            0,
            2,
            8,
          ),
        ],
        stops: const [0.35, 1],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, paint);
  }

  void _paintGrain(Canvas canvas, Size size) {
    if (config.grainOpacity <= 0) return;

    final paint = Paint()
      ..color = Color.fromARGB(
        (config.grainOpacity * 255).round(),
        255,
        255,
        255,
      )
      ..strokeWidth = 0.45;

    const spacing = 5.0;
    for (double y = 0; y < size.height; y += spacing) {
      final double offset = (y % 2 == 0) ? 0.0 : spacing * 0.5;
      for (double x = offset; x < size.width; x += spacing) {
        final noise = math.sin(x * 12.9898 + y * 78.233 + progress * 31.7);
        if (noise > 0.82) {
          canvas.drawPoints(PointMode.points, [Offset(x, y)], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StormSkyShaderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.config != config;
  }
}
