import 'package:clima_app/features/weather/presentation/animations/configs/weather_animation_config.dart';
import 'package:clima_app/features/weather/presentation/enums/particle_type.dart';
import 'package:clima_app/features/weather/presentation/layers/atmosphere/cloud_rive_layer.dart';
import 'package:clima_app/features/weather/presentation/layers/atmosphere/fog_layer.dart';
import 'package:clima_app/features/weather/presentation/layers/background/dynamic_sky_shader_layer.dart';
import 'package:clima_app/features/weather/presentation/layers/background/weather_gradient_background.dart';
import 'package:clima_app/features/weather/presentation/layers/effects/lightning_effect_layer.dart';
import 'package:clima_app/features/weather/presentation/layers/effects/storm_darkening_layer.dart';
import 'package:clima_app/features/weather/presentation/layers/overlay/premium_weather_overlay.dart';
import 'package:clima_app/features/weather/presentation/layers/overlay/weather_scene_overlay_data.dart';
import 'package:clima_app/features/weather/presentation/layers/particles/rain_particle_layer.dart';
import 'package:flutter/material.dart';

class WeatherScene extends StatelessWidget {
  final WeatherAnimationConfig config;
  final WeatherSceneOverlayData? overlayData;

  const WeatherScene({
    super.key,
    required this.config,
    this.overlayData,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: WeatherGradientBackground(
            config: config.skyGradient,
          ),
        ),
        /*Positioned.fill(
          child: DynamicSkyShaderLayer(
            config: config.shaderConfig,
          ),
        ),
        Positioned.fill(
          child: CloudRiveLayer(
            config: config.atmosphereConfig,
          ),
        ),
        Positioned.fill(
          child: FogLayer(
            config: config.atmosphereConfig,
          ),
        ),
        if (config.particleConfig.particleType == ParticleType.rain)
          Positioned.fill(
            child: RainParticleLayer(
              config: config.particleConfig,
            ),
          ),
        Positioned.fill(
          child: StormDarkeningLayer(
            config: config.effectsConfig,
          ),
        ),
        if (config.effectsConfig.lightningEnabled)
          Positioned.fill(
            child: LightningEffectLayer(
              config: config.effectsConfig,
            ),
          ),
         */
        if (overlayData != null)
          Positioned.fill(
            child: PremiumWeatherOverlay(
              data: overlayData!,
            ),
          ),
      ],
    );
  }
}
