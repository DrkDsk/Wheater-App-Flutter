import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/home/domain/entities/city_weather_data.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:clima_app/features/home/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:dartz/dartz.dart';

class GetWeatherUseCase {
  final SearchWeatherRepository _searchWeatherRepository;
  final LocationRepository _locationRepository;

  final WeatherMapper mapper;

  GetWeatherUseCase({
    required SearchWeatherRepository searchWeatherRepository,
    required LocationRepository locationRepository,
    required this.mapper,
  })  : _searchWeatherRepository = searchWeatherRepository,
        _locationRepository = locationRepository;

  Future<Either<Failure, CityWeatherData>> call(
      {Coordinate? coordinate}) async {
    if (coordinate == null) {
      final currentLocation = await _locationRepository.getCurrentLocation();
      coordinate = currentLocation.toCoordinate();
    }

    final forecastEither = await _searchWeatherRepository.getWeatherByLocation(
      lat: coordinate.latitude,
      lon: coordinate.longitude,
    );

    return forecastEither.fold(
      Left.new,
      (forecastData) async {
        final limitedForecast = forecastData.copyWith(
          hourly: forecastData.hourly.take(12).toList(),
          daily: forecastData.daily.take(12).toList(),
        );

        final weatherCondition = forecastData.current.weather.first.toEntity();

        final translatedWeather = await mapper.map(weatherCondition);

        return Right(
          CityWeatherData(
            forecast: limitedForecast,
            translatedWeather: translatedWeather,
          ),
        );
      },
    );
  }
}
