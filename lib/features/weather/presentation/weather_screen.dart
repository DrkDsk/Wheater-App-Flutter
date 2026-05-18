import 'package:clima_app/features/weather/presentation/animations/configs/weather_animation_config.dart';
import 'package:clima_app/features/weather/presentation/layers/overlay/weather_scene_overlay_data.dart';
import 'package:clima_app/features/weather/presentation/weather_scene.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherAnimationConfig config;
  final WeatherSceneOverlayData overlayData;

  const WeatherScreen({
    super.key,
    required this.config,
    required this.overlayData,
  });

  @override
  Widget build(BuildContext context) {
    return WeatherScene(
      config: config,
      overlayData: overlayData,
    );
  }
}
