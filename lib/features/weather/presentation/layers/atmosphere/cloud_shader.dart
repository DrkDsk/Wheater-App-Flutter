import 'package:clima_app/features/weather/presentation/animations/configs/atmosphere_config.dart';
import 'package:flutter/material.dart';

class CloudShader extends StatefulWidget {
  final AtmosphereConfig config;

  const CloudShader({
    super.key,
    required this.config,
  });

  @override
  State<CloudShader> createState() => _CloudShaderState();
}

class _CloudShaderState extends State<CloudShader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CloudShader oldWidget) {
    super.didUpdateWidget(oldWidget);
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
