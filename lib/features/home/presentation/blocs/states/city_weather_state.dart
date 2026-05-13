import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/home/domain/entities/city_weather_data.dart';
import 'package:equatable/equatable.dart';

enum CityWeatherStatus {
  initial,
  loading,
  failure,
  success;
}

final class CityWeatherState with EquatableMixin {
  final CityWeatherData? cityWeatherData;
  final CityWeatherStatus status;
  final List<CityLocation> cities;
  final BackgroundWeather backgroundWeather;
  final String message;

  const CityWeatherState({
    this.cityWeatherData,
    required this.cities,
    required this.status,
    required this.message,
    required this.backgroundWeather,
  });

  factory CityWeatherState.initial() {
    return CityWeatherState(
      cities: [],
      status: CityWeatherStatus.initial,
      message: '',
      backgroundWeather: BackgroundWeather.initial(),
    );
  }

  CityWeatherState copyWith({
    CityWeatherData? cityWeatherData,
    CityWeatherStatus? status,
    List<CityLocation>? cities,
    BackgroundWeather? backgroundWeather,
    String? message,
  }) {
    return CityWeatherState(
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
