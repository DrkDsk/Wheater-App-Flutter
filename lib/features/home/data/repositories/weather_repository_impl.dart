import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource.dart';
import 'package:clima_app/features/home/domain/entities/forecast.dart';
import 'package:clima_app/features/home/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final SearchWeatherDataSource datasource;

  WeatherRepositoryImpl({required this.datasource});

  @override
  Future<Forecast> getWeatherByLocation({
    required double lat,
    required double lon,
  }) async {
    try {
      final model = await datasource.fetchSearchDataByLocation(
        lat: lat,
        lon: lon,
      );

      final forecastData = model.toEntity();

      final limitedForecast = forecastData.copyWith(
        hourly: forecastData.hourly.take(12).toList(),
        daily: forecastData.daily.take(12).toList(),
      );

      return limitedForecast;
    } on UnknownException catch (e) {
      throw UnexpectedFailure(e.message);
    } on NetworkException catch (e) {
      throw UnexpectedFailure(e.message);
    }
  }
}
