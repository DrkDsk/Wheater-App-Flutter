import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:equatable/equatable.dart';

import 'forecast.dart';

class CityWeatherData with EquatableMixin {
  final Forecast forecast;
  final TranslatedWeather translatedWeather;
  final String cityName;

  CityWeatherData({
    required this.forecast,
    required this.translatedWeather,
    required this.cityName,
  });

  @override
  List<Object?> get props => [forecast, translatedWeather, cityName];
}
