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

  Future<Either<Failure, CityWeatherData>> call({
    required Coordinate coordinate,
  }) async {
    final forecastEither = await _searchWeatherRepository.getWeatherByLocation(
      lat: coordinate.latitude,
      lon: coordinate.longitude,
    );

    return forecastEither.fold(
      Left.new,
      (forecastData) async {
        final weatherCondition = forecastData.current.weather.first.toEntity();

        final translatedWeather = await mapper.map(weatherCondition);

        final locationInfo = await _locationRepository.getLocationInformation(
          latitude: coordinate.latitude,
          longitude: coordinate.longitude,
        );

        final cityInfo =
            "${locationInfo?.name} ${locationInfo?.administrativeArea}";

        return Right(
          CityWeatherData(
            cityName: cityInfo,
            forecast: forecastData,
            translatedWeather: translatedWeather,
          ),
        );
      },
    );
  }
}
