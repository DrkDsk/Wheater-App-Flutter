import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class GetFavoritesAndCurrentLocationUseCase {
  final LocationRepository _locationRepository;
  final FavoriteRepository _favoriteRepository;

  const GetFavoritesAndCurrentLocationUseCase({
    required LocationRepository locationRepository,
    required FavoriteRepository favoriteRepository,
  })  : _locationRepository = locationRepository,
        _favoriteRepository = favoriteRepository;

  Future<Either<Failure, List<CityLocation>>> call() async {
    final (locationCached, favoritesCities) = await (
      _locationRepository.getCurrentLocation(),
      _favoriteRepository.index()
    ).wait;

    return favoritesCities.fold((error) {
      return Left(error);
    }, (data) {
      return Right([locationCached, ...data]);
    });
  }
}
