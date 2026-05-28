import 'dart:math' as math;
import 'dart:ui' show PointMode;

import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/features/weather/presentation/animations/configs/shader_config.dart';
import 'package:clima_app/features/weather/presentation/enums/shader_type.dart';
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
              painter: CompositeAtmospherePainter(
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

class CompositeAtmospherePainter extends CustomPainter {
  final ShaderConfig config;
  final double progress;

  const CompositeAtmospherePainter({
    required this.config,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final time = progress * math.pi * 2 * config.animationSpeed;

    final drift = math.sin(time) * size.width * 0.08;

    _paintAtmosphericLighting(canvas, size, time);
    _paintCloudShadow(canvas, size, drift);
    _paintFogDensity(canvas, size);
    _paintAtmosphericNoise(canvas, size, time);
    _paintVignette(canvas, size);

    if (config.shaderTypes.contains(
      ShaderType.volumetricFog,
    )) {
      _paintVolumetricFog(
        canvas,
        size,
        time,
      );
    }

    if (config.shaderTypes.contains(
      ShaderType.heatDistortion,
    )) {
      _paintHeatDistortion(
        canvas,
        size,
        time,
      );
    }

    if (config.shaderTypes.contains(
      ShaderType.aurora,
    )) {
      _paintAurora(
        canvas,
        size,
        time,
      );
    }

    if (config.shaderTypes.contains(
      ShaderType.moonGlow,
    )) {
      _paintMoonGlow(
        canvas,
        size,
      );
    }
  }

  void _paintCloudShadow(
    Canvas canvas,
    Size size,
    double time,
  ) {
    if (config.cloudShadowIntensity <= 0) {
      return;
    }

    final drift =
        math.sin(time * 0.4) * size.width * config.windFlowIntensity * 0.08;

    final opacity = config.cloudShadowIntensity * 0.35;

    final paint = Paint()
      ..blendMode = BlendMode.multiply
      ..shader = RadialGradient(
        center: Alignment(
          -0.45 + drift / size.width,
          -0.78,
        ),
        radius: 1.3,
        colors: [
          Color.fromARGB(
            (opacity * 255).round(),
            0,
            0,
            0,
          ),
          Colors.transparent,
        ],
      ).createShader(
        Offset.zero & size,
      );

    canvas.drawRect(Offset.zero & size, paint);
  }

  void _paintAtmosphericLighting(
    Canvas canvas,
    Size size,
    double time,
  ) {
    final bend = math.sin(
          time * config.turbulenceIntensity,
        ) *
        0.15;

    final paint = Paint()
      ..blendMode = BlendMode.screen
      ..shader = LinearGradient(
        begin: Alignment(-1 + bend, -1),
        end: Alignment(1 + bend, 1),
        colors: [
          Color.lerp(
            const Color(0xFF7EAFFF),
            const Color(0xFFB7D7FF),
            config.warmTintStrength,
          )!
              .customOpacity(
            0.08 * config.exposure,
          ),
          Color.lerp(
            const Color(0xFF3C4E67),
            const Color(0xFFFFC58A),
            config.warmTintStrength,
          )!
              .customOpacity(
            0.14 * config.exposure,
          ),
          Colors.transparent,
        ],
      ).createShader(
        Offset.zero & size,
      );

    canvas.drawRect(
      Offset.zero & size,
      paint,
    );
  }

  void _paintFogDensity(
    Canvas canvas,
    Size size,
  ) {
    if (config.fogDensity <= 0) {
      return;
    }

    final opacity = config.fogDensity * 0.55;

    final paint = Paint()
      ..blendMode = BlendMode.softLight
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.customOpacity(
            opacity * 0.15,
          ),
          Colors.white.customOpacity(
            opacity,
          ),
        ],
      ).createShader(
        Offset.zero & size,
      );

    canvas.drawRect(
      Offset.zero & size,
      paint,
    );
  }

  void _paintAtmosphericNoise(
    Canvas canvas,
    Size size,
    double time,
  ) {
    if (config.atmosphericNoiseOpacity <= 0) {
      return;
    }

    final paint = Paint()
      ..color = Colors.white.customOpacity(
        config.atmosphericNoiseOpacity,
      )
      ..strokeWidth = 0.45;

    const spacing = 6.0;

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        final noise = math.sin(
          x * 12.9898 + y * 78.233 + time * 4,
        );

        if (noise > 0.88) {
          canvas.drawPoints(
            PointMode.points,
            [Offset(x, y)],
            paint,
          );
        }
      }
    }
  }

  void _paintVignette(Canvas canvas, Size size) {
    if (config.vignetteIntensity <= 0) {
      return;
    }

    final paint = Paint()
      ..shader = RadialGradient(
        radius: 1,
        colors: [
          Colors.transparent,
          Colors.black.customOpacity(
            config.vignetteIntensity * 0.6,
          ),
        ],
        stops: const [0.45, 1],
      ).createShader(
        Offset.zero & size,
      );

    canvas.drawRect(Offset.zero & size, paint);
  }

  void _paintVolumetricFog(
    Canvas canvas,
    Size size,
    double time,
  ) {
    final drift = math.sin(time * 0.15) * 0.08;
    final opacity = config.fogDensity * 0.25;
    final rect = Offset.zero & size;

    final paint = Paint()
      ..blendMode = BlendMode.softLight
      ..shader = LinearGradient(
        begin: Alignment(-1 + drift, 0.2),
        end: Alignment(1 + drift, 1),
        colors: [
          Colors.white.customOpacity(0),
          Colors.white.customOpacity(opacity * 0.6),
          Colors.white.customOpacity(opacity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 0.7, 1],
      ).createShader(rect);

    canvas.drawRect(rect, paint);
  }

  void _paintHeatDistortion(
    Canvas canvas,
    Size size,
    double time,
  ) {
    final distortion = math.sin(time * 2.0) * 0.03;

    final paint = Paint()
      ..blendMode = BlendMode.softLight
      ..shader = LinearGradient(
        begin: Alignment(
          -1 + distortion,
          -1,
        ),
        end: Alignment(
          1 + distortion,
          1,
        ),
        colors: [
          Colors.transparent,
          Colors.white.customOpacity(
            0.025,
          ),
          Colors.transparent,
        ],
      ).createShader(
        Offset.zero & size,
      );

    canvas.drawRect(
      Offset.zero & size,
      paint,
    );
  }

  void _paintAurora(
    Canvas canvas,
    Size size,
    double time,
  ) {
    final wave = math.sin(time * 0.4) * 0.15;

    final rect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height * 0.6,
    );

    final paint = Paint()
      ..blendMode = BlendMode.screen
      ..shader = LinearGradient(
        begin: Alignment(-0.5 + wave, -1),
        end: Alignment(0.5 + wave, 1),
        colors: const [
          Color(0x6600FFB7),
          Color(0x5527C1FF),
          Color(0x4400FFD0),
        ],
      ).createShader(rect);

    final path = Path()..moveTo(0, size.height * 0.2);

    for (double x = 0; x <= size.width; x += 12) {
      final y = size.height * 0.22 +
          math.sin(
                (x / size.width) * 6 + time,
              ) *
              28;

      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  void _paintMoonGlow(
    Canvas canvas,
    Size size,
  ) {
    final moonPosition = Offset(
      size.width * 0.78,
      size.height * 0.18,
    );

    final radius = size.width * 0.22;

    final paint = Paint()
      ..blendMode = BlendMode.screen
      ..shader = RadialGradient(
        colors: [
          Colors.white.customOpacity(0.16),
          Colors.blueGrey.customOpacity(0.05),
          Colors.transparent,
        ],
        stops: const [0, 0.45, 1],
      ).createShader(
        Rect.fromCircle(
          center: moonPosition,
          radius: radius,
        ),
      );

    canvas.drawCircle(
      moonPosition,
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CompositeAtmospherePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.config != config;
  }
}
