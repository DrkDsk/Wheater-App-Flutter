import 'dart:ui';

import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/favorites/presentation/widgets/header_weather_sheet.dart';
import 'package:clima_app/features/favorites/presentation/widgets/weather_data_inherited.dart';
import 'package:clima_app/features/weather/presentation/layers/overlay/weather_scene_overlay_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class PremiumWeatherOverlay extends StatelessWidget {
  final WeatherSceneOverlayData data;

  const PremiumWeatherOverlay({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final weatherDataToStore = WeatherDataInherited.of(context);
    final isAvailableToStore = weatherDataToStore?.isAvailableToStore ?? false;
    final cityLocation = weatherDataToStore?.cityLocation;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2.h,
          children: [
            if (isAvailableToStore && cityLocation != null) ...[
              HeaderWeatherSheet(
                isAbleToSave: isAvailableToStore,
                onCancel: () => AppRouter.of(context).pop(),
                onSave: () {
                  BlocProvider.of<FavoriteCubit>(context).store(
                    cityLocation: cityLocation,
                  );
                },
              )
            ],
            _GlassPanel(
              children: [
                Text(
                  data.cityName,
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.white.customOpacity(0.82),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  data.temperature,
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    height: 0.92,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  data.condition,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.customOpacity(0.78),
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            _GlassPanel(
              divider: 2,
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
  final int divider;

  const _GlassPanel({
    required this.children,
    this.divider = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF071221).customOpacity(0.20),
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
                final tileWidth = (constraints.maxWidth - 12) / divider;

                return Wrap(
                  spacing: 2.w,
                  runSpacing: 2.h,
                  direction: Axis.horizontal,
                  children: [
                    for (final child in children)
                      SizedBox(
                        width: tileWidth,
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
    final textTheme = theme.textTheme;

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
              size: 19.sp,
              color: Colors.white.customOpacity(0.68),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelMedium?.copyWith(
                    color: Colors.white.customOpacity(0.46),
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
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
