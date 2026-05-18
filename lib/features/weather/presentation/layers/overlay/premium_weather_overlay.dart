import 'dart:ui';

import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/features/weather/presentation/layers/overlay/weather_scene_overlay_data.dart';
import 'package:flutter/material.dart';

class PremiumWeatherOverlay extends StatelessWidget {
  final WeatherSceneOverlayData data;

  const PremiumWeatherOverlay({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.cityName,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white.customOpacity(0.82),
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              data.temperature,
              style: theme.textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontFamily: 'Outfit',
                fontSize: 92,
                height: 0.92,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              data.condition,
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white.customOpacity(0.78),
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            _GlassPanel(
              children: [
                _MetricTile(
                  icon: Icons.thermostat_rounded,
                  label: 'Sensacion',
                  value: data.feelsLike,
                ),
                _MetricTile(
                  icon: Icons.water_drop_rounded,
                  label: 'Humedad',
                  value: data.humidity,
                ),
                _MetricTile(
                  icon: Icons.air_rounded,
                  label: 'Viento',
                  value: data.wind,
                ),
                _MetricTile(
                  icon: Icons.grain_rounded,
                  label: 'Lluvia',
                  value: data.rain,
                ),
                _MetricTile(
                  icon: Icons.visibility_rounded,
                  label: 'Visibilidad',
                  value: data.visibility,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  final List<Widget> children;

  const _GlassPanel({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF071221).customOpacity(0.36),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.customOpacity(0.13),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tileWidth = (constraints.maxWidth - 12) / 2;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (final child in children)
                      SizedBox(
                        width: tileWidth,
                        height: 82,
                        child: child,
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.customOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.customOpacity(0.09),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              size: 19,
              color: Colors.white.customOpacity(0.68),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white.customOpacity(0.46),
                    fontFamily: 'Outfit',
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
