import 'package:clima_app/features/weather/presentation/animations/configs/weather_animation_config.dart';
import 'package:clima_app/features/weather/presentation/enums/particle_type.dart';
import 'package:clima_app/features/weather/presentation/layers/atmosphere/cloud_layer.dart';
import 'package:clima_app/features/weather/presentation/layers/background/weather_content_layer.dart';
import 'package:clima_app/features/weather/presentation/layers/background/weather_gradient_background.dart';
import 'package:clima_app/features/weather/presentation/layers/effects/lightning_effect_layer.dart';
import 'package:clima_app/features/weather/presentation/layers/particles/rain_particle_layer.dart';
import 'package:flutter/material.dart';

class WeatherScene extends StatelessWidget {
  final WeatherAnimationConfig config;

  const WeatherScene({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherGradientBackground(
          config: config.skyGradient,
        ),

        CloudLayer(
          config: config.atmosphereConfig,
        ),

        /// 🌧 PARTICLES
        if (config.particleConfig.particleType == ParticleType.rain)
          RainParticleLayer(
            config: config.particleConfig,
          ),

        /// ⚡ FX
        if (config.effectsConfig.lightningEnabled)
          LightningEffectLayer(
            config: config.effectsConfig,
          ),

        /// 📱 UI
        const WeatherContentLayer(),
      ],
    );
  }
}
