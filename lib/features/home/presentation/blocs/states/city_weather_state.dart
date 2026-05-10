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

class CityWeatherState with EquatableMixin {
  final CityWeatherData? cityWeatherData;
  final CityWeatherStatus status;
  final List<CityLocation> cities;
  final String errorMessage;
  final BackgroundWeather backgroundWeather;

  const CityWeatherState({
    this.cityWeatherData,
    required this.cities,
    required this.status,
    required this.errorMessage,
    required this.backgroundWeather,
  });

  CityWeatherState copyWith({
    CityWeatherData? cityWeatherData,
    CityWeatherStatus? status,
    List<CityLocation>? cities,
    String? errorMessage,
    BackgroundWeather? backgroundWeather,
  }) {
    return CityWeatherState(
      cityWeatherData: cityWeatherData ?? this.cityWeatherData,
      backgroundWeather: backgroundWeather ?? this.backgroundWeather,
      status: status ?? this.status,
      cities: cities ?? this.cities,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory CityWeatherState.initial() {
    return CityWeatherState(
      cities: [],
      status: CityWeatherStatus.initial,
      errorMessage: '',
      backgroundWeather: BackgroundWeather.initial(),
    );
  }

  @override
  List<Object?> get props => [
        cityWeatherData,
        status,
        cities,
        errorMessage,
        backgroundWeather,
      ];
}
