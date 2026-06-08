import 'dart:ui' as ui;

import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:flutter/material.dart';

class CloudShader extends CloudShaderWidget {
  const CloudShader({
    super.key,
    required super.config,
  });
}

class CloudShaderWidget extends StatelessWidget {
  final AtmosphereConfig config;

  const CloudShaderWidget({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    if (config.cloudOpacity <= 0 || config.cloudDensity <= 0) {
      return const SizedBox.shrink();
    }

    return _CloudShaderRenderer(config: config);
  }
}

class _CloudShaderRenderer extends StatefulWidget {
  final AtmosphereConfig config;

  const _CloudShaderRenderer({
    required this.config,
  });

  @override
  State<_CloudShaderRenderer> createState() => _CloudShaderRendererState();
}

class _CloudShaderRendererState extends State<_CloudShaderRenderer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Future<ui.FragmentProgram> _program;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 240),
    )..repeat();
    _program = CloudShaderPainter.loadProgram();
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
        child: FutureBuilder<ui.FragmentProgram>(
          future: _program,
          builder: (context, snapshot) {
            final program = snapshot.data;
            if (program == null) {
              return const SizedBox.expand();
            }

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: CloudShaderPainter(
                    program: program,
                    config: widget.config,
                    elapsed: _controller.lastElapsedDuration ??
                        (_controller.duration! * _controller.value),
                  ),
                  size: Size.infinite,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CloudShaderPainter extends CustomPainter {
  static const String shaderAsset = 'shaders/clouds.frag';

  final ui.FragmentProgram program;
  final AtmosphereConfig config;
  final Duration elapsed;

  const CloudShaderPainter({
    required this.program,
    required this.config,
    required this.elapsed,
  });

  static Future<ui.FragmentProgram> loadProgram() {
    return ui.FragmentProgram.fromAsset(shaderAsset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || config.cloudOpacity <= 0 || config.cloudDensity <= 0) {
      return;
    }

    final shader = program.fragmentShader()
      // uResolution: viewport size in logical pixels.
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      // uTime: elapsed seconds used only for noise-domain scrolling.
      ..setFloat(2, elapsed.inMilliseconds / 1000)
      // uCloudCoverage: amount of sky occupied by cloud masses.
      ..setFloat(3, config.cloudCoverage)
      // uCloudDensity: visual strength of the generated cloud body.
      ..setFloat(4, config.cloudDensity)
      // uCloudOpacity: final fragment alpha multiplier.
      ..setFloat(5, config.cloudOpacity)
      // uCloudSpeed: domain scrolling speed.
      ..setFloat(6, config.cloudSpeed)
      // uCloudScale: size of the cloud structures.
      ..setFloat(7, config.cloudScale)
      // uCloudSoftness: smoothstep feather width for atmospheric edges.
      ..setFloat(8, config.cloudSoftness);

    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = shader
        ..blendMode = BlendMode.srcOver,
    );
  }

  @override
  bool shouldRepaint(covariant CloudShaderPainter oldDelegate) {
    return oldDelegate.program != program ||
        oldDelegate.config != config ||
        oldDelegate.elapsed != elapsed;
  }
}
