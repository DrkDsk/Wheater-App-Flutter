import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:clima_app/features/home/domain/repositories/weather_repository.dart';
import 'package:clima_app/features/home/presentation/weather_list_item.dart';
import 'package:dartz/dartz.dart';

class GetFavoritesAndCurrentLocationUseCase {
  final LocationRepository _locationRepository;
  final FavoriteRepository _favoriteRepository;
  final WeatherRepository _weatherRepository;

  const GetFavoritesAndCurrentLocationUseCase({
    required LocationRepository locationRepository,
    required FavoriteRepository favoriteRepository,
    required WeatherRepository weatherRepository,
  })  : _locationRepository = locationRepository,
        _favoriteRepository = favoriteRepository,
        _weatherRepository = weatherRepository;

  Future<Either<Failure, List<WeatherListItem>>> call() async {
    try {
      final (locationCached, favoritesCities) = await (
        _locationRepository.getCurrentLocation(),
        _favoriteRepository.index()
      ).wait;

      final currentWeather = await _weatherRepository.getWeatherByLocation(
        lat: locationCached.latitude,
        lon: locationCached.longitude,
      );

      return favoritesCities.fold((error) {
        return Left(error);
      }, (data) {
        final pages = <WeatherListItem>[
          CurrentLocationItem(forecast: currentWeather),
          ...data.map((favorite) {
            return FavoriteWeatherItem(cityLocation: favorite);
          })
        ];

        return Right(pages);
      });
    } on UnexpectedFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
