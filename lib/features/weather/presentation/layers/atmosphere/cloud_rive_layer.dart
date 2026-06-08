import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:flutter/material.dart';

class CloudLayer extends StatefulWidget {
  final AtmosphereConfig config;

  const CloudLayer({
    super.key,
    required this.config,
  });

  @override
  State<CloudLayer> createState() => _CloudLayerState();
}

class _CloudLayerState extends State<CloudLayer>
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
  void didUpdateWidget(covariant CloudLayer oldWidget) {
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
              return const Stack(
                fit: StackFit.expand,
                children: [],
              );
            },
          ),
        ),
      ),
    );
  }
}
