import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/home/domain/entities/weather_data.dart';
import 'package:equatable/equatable.dart';

enum WeatherStatus {
  initial,
  loading,
  failure,
  success;
}

final class WeatherState with EquatableMixin {
  final WeatherData? cityWeatherData;
  final WeatherStatus status;
  final List<CityLocation> cities;
  final BackgroundWeather backgroundWeather;
  final String message;

  const WeatherState({
    this.cityWeatherData,
    required this.cities,
    required this.status,
    required this.message,
    required this.backgroundWeather,
  });

  factory WeatherState.initial() {
    return WeatherState(
      cities: [],
      status: WeatherStatus.initial,
      message: '',
      backgroundWeather: BackgroundWeather.initial(),
    );
  }

  WeatherState copyWith({
    WeatherData? cityWeatherData,
    WeatherStatus? status,
    List<CityLocation>? cities,
    BackgroundWeather? backgroundWeather,
    String? message,
  }) {
    return WeatherState(
      cityWeatherData: cityWeatherData ?? this.cityWeatherData,
      status: status ?? this.status,
      cities: cities ?? this.cities,
      backgroundWeather: backgroundWeather ?? this.backgroundWeather,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        cityWeatherData,
        status,
        cities,
        message,
        backgroundWeather,
      ];
}
