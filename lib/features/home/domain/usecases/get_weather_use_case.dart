import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/core/extensions/placemark_extension.dart';
import 'package:clima_app/features/home/domain/entities/city_weather_data.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/geo_locator_repository.dart';
import 'package:clima_app/features/home/domain/repositories/weather_repository.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:dartz/dartz.dart';

class GetWeatherUseCase {
  final WeatherRepository _searchWeatherRepository;
  final GeoLocatorRepository _locationRepository;

  final WeatherMapper mapper;

  GetWeatherUseCase({
    required WeatherRepository searchWeatherRepository,
    required GeoLocatorRepository locationRepository,
    required this.mapper,
  })  : _searchWeatherRepository = searchWeatherRepository,
        _locationRepository = locationRepository;

  Future<Either<Failure, CityWeatherData>> call({
    required Coordinate coordinate,
  }) async {
    try {
      final forecast = await _searchWeatherRepository.getWeatherByLocation(
        lat: coordinate.latitude,
        lon: coordinate.longitude,
      );

      final weatherCondition = forecast.current.weather.first.toEntity();

      final translatedWeather = await mapper.map(weatherCondition);

      final locationInfo = await _locationRepository.getLocationInformation(
        latitude: coordinate.latitude,
        longitude: coordinate.longitude,
      );

      final cityInfo = locationInfo?.getDisplayName ?? "";

      return Right(
        CityWeatherData(
          cityName: cityInfo,
          forecast: forecast,
          translatedWeather: translatedWeather,
        ),
      );
    } on UnexpectedFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
