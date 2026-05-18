import 'dart:ui';

import 'package:clima_app/features/home/domain/entities/weather_data.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';

class WeatherStatusContentData {
  final WeatherStatus status;
  final WeatherData? data;
  final Color bgColor;

  const WeatherStatusContentData({
    required this.status,
    required this.bgColor,
    this.data,
  });
}
