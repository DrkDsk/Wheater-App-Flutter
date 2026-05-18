import 'package:clima_app/features/weather/presentation/animations/configs/sky_gradient_config.dart';
import 'package:flutter/material.dart';

class WeatherGradientBackground extends StatefulWidget {
  final SkyGradientConfig config;

  const WeatherGradientBackground({
    super.key,
    required this.config,
  });

  @override
  State<WeatherGradientBackground> createState() =>
      _WeatherGradientBackgroundState();
}

class _WeatherGradientBackgroundState extends State<WeatherGradientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final shift =
            widget.config.animatedShift * (_controller.value - 0.5) * 2;
        final begin = Alignment(
          widget.config.begin.x + shift,
          widget.config.begin.y,
        );
        final end = Alignment(
          widget.config.end.x - shift,
          widget.config.end.y,
        );

        return Stack(
          fit: StackFit.expand,
          children: [
            AnimatedContainer(
              duration: widget.config.transitionDuration,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.config.colors,
                  stops: widget.config.stops,
                  begin: begin,
                  end: end,
                ),
              ),
            ),
            if (widget.config.radialAccentColor != null)
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: widget.config.radialAccentAlignment,
                    radius: widget.config.radialAccentRadius,
                    colors: [
                      widget.config.radialAccentColor!.withAlpha(70),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
