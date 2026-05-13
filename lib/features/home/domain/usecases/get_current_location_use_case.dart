import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/core/extensions/placemark_extension.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:clima_app/features/home/presentation/weather_list_item.dart';
import 'package:dartz/dartz.dart';

class GetFavoritesAndCurrentLocationUseCase {
  final LocationRepository _locationRepository;
  final FavoriteRepository _favoriteRepository;

  const GetFavoritesAndCurrentLocationUseCase({
    required LocationRepository locationRepository,
    required FavoriteRepository favoriteRepository,
  })  : _locationRepository = locationRepository,
        _favoriteRepository = favoriteRepository;

  Future<Either<Failure, List<WeatherListItem>>> call() async {
    try {
      final (locationCached, favoritesCities) = await (
        _locationRepository.getCurrentLocation(),
        _favoriteRepository.index()
      ).wait;

      final currentLocationName =
          await _locationRepository.getLocationInformation(
        latitude: locationCached.latitude,
        longitude: locationCached.longitude,
      );

      final displayName = currentLocationName?.getDisplayName ?? "";

      return favoritesCities.fold((error) {
        return Left(error);
      }, (data) {
        final pages = <WeatherListItem>[
          CurrentLocationItem(
            cityName: displayName,
            coordinate: Coordinate(
              latitude: locationCached.latitude,
              longitude: locationCached.longitude,
            ),
          ),
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
