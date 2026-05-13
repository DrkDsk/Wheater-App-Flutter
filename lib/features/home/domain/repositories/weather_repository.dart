import 'package:clima_app/features/home/domain/entities/forecast.dart';

abstract interface class WeatherRepository {
  Future<Forecast> getWeatherByLocation({
    required double lat,
    required double lon,
  });
}
