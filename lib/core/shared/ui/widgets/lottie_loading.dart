import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/core/shared/ui/widgets/lottie_viewer.dart';
import 'package:flutter/material.dart';

class LottieLoading extends StatefulWidget {
  const LottieLoading({super.key});

  @override
  State<LottieLoading> createState() => _LottieLoadingState();
}

class _LottieLoadingState extends State<LottieLoading> {
  late final BackgroundWeather _emptyBackgroundWeather;

  @override
  void initState() {
    super.initState();
    _emptyBackgroundWeather = BackgroundWeather.initial();
  }

  @override
  Widget build(BuildContext context) {
    return LottieViewer(
      path: _emptyBackgroundWeather.lottiePath,
      backgroundColor: _emptyBackgroundWeather.color,
    );
  }
}
