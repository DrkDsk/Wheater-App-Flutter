import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CloudRiveLayer extends StatefulWidget {
  final AtmosphereConfig config;

  const CloudRiveLayer({
    super.key,
    required this.config,
  });

  @override
  State<CloudRiveLayer> createState() => _CloudRiveLayerState();
}

class _CloudRiveLayerState extends State<CloudRiveLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.config.cloudDriftDuration,
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant CloudRiveLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.cloudDriftDuration !=
        widget.config.cloudDriftDuration) {
      _controller.duration = widget.config.cloudDriftDuration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: widget.config.cloudOpacity,
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  if (widget.config.riveCloudAsset != null)
                    _RiveCloudAsset(
                      assetPath: widget.config.riveCloudAsset!,
                      fallback: CustomPaint(
                        painter: _SoftCloudPainter(
                          progress: _controller.value,
                          density: widget.config.cloudDensity,
                          scale: widget.config.cloudScale,
                          parallaxStrength: widget.config.parallaxStrength,
                        ),
                      ),
                    )
                  else
                    CustomPaint(
                      painter: _SoftCloudPainter(
                        progress: _controller.value,
                        density: widget.config.cloudDensity,
                        scale: widget.config.cloudScale,
                        parallaxStrength: widget.config.parallaxStrength,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RiveCloudAsset extends StatefulWidget {
  final String assetPath;
  final Widget fallback;

  const _RiveCloudAsset({
    required this.assetPath,
    required this.fallback,
  });

  @override
  State<_RiveCloudAsset> createState() => _RiveCloudAssetState();
}

class _RiveCloudAssetState extends State<_RiveCloudAsset> {
  late FileLoader _fileLoader;

  @override
  void initState() {
    super.initState();
    _fileLoader = _createLoader();
  }

  @override
  void didUpdateWidget(covariant _RiveCloudAsset oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      _fileLoader.dispose();
      _fileLoader = _createLoader();
    }
  }

  @override
  void dispose() {
    _fileLoader.dispose();
    super.dispose();
  }

  FileLoader _createLoader() {
    return FileLoader.fromAsset(
      widget.assetPath,
      riveFactory: Factory.rive,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RiveWidgetBuilder(
      fileLoader: _fileLoader,
      builder: (context, state) => switch (state) {
        RiveLoaded() => RiveWidget(
            controller: state.controller,
            fit: Fit.cover,
          ),
        RiveLoading() || RiveFailed() => widget.fallback,
      },
    );
  }
}

class _SoftCloudPainter extends CustomPainter {
  final double progress;
  final double density;
  final double scale;
  final double parallaxStrength;

  const _SoftCloudPainter({
    required this.progress,
    required this.density,
    required this.scale,
    required this.parallaxStrength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final cloudCount = (4 + density * 5).round();
    for (int i = 0; i < cloudCount; i++) {
      final layerDepth = 0.5 + (i % 3) * 0.28;
      final width = size.width * (0.6 + (i % 4) * 0.12) * scale;
      final height = width * (0.28 + (i % 2) * 0.06);
      final baseY = size.height * (0.06 + (i * 0.105));
      final driftDistance = size.width * (0.24 + layerDepth * 0.2);
      final direction = i.isEven ? 1.0 : -1.0;
      final phase = (progress + i * 0.19) % 1;
      final centerX = size.width * ((i * 0.31) % 1) +
          ((phase - 0.5) * driftDistance * direction * parallaxStrength);

      final rect = Rect.fromCenter(
        center: Offset(centerX, baseY),
        width: width,
        height: height,
      );

      _paintCloud(canvas, rect, layerDepth);
    }
  }

  void _paintCloud(Canvas canvas, Rect rect, double depth) {
    final paint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 22 * depth)
      ..shader = RadialGradient(
        center: const Alignment(-0.25, -0.3),
        radius: 0.92,
        colors: [
          Color.fromARGB(
              (74 * density / depth).clamp(16, 82).round(), 200, 220, 238),
          Color.fromARGB(
              (30 * density / depth).clamp(8, 34).round(), 82, 108, 132),
          Colors.transparent,
        ],
        stops: const [0, 0.58, 1],
      ).createShader(rect);

    canvas.drawOval(rect, paint);
    canvas.drawOval(
      rect.shift(Offset(rect.width * 0.28, rect.height * -0.08)),
      paint,
    );
    canvas.drawOval(
      rect.shift(Offset(rect.width * -0.24, rect.height * 0.03)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _SoftCloudPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.density != density ||
        oldDelegate.scale != scale ||
        oldDelegate.parallaxStrength != parallaxStrength;
  }
}
