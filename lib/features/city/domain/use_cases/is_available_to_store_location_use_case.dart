import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/home/domain/repositories/geo_locator_repository.dart';

class IsAvailableToStoreLocationUseCase {
  final FavoriteRepository _favoriteRepository;
  final GeoLocatorRepository _geoLocatorRepository;

  const IsAvailableToStoreLocationUseCase({
    required FavoriteRepository favoriteRepository,
    required GeoLocatorRepository geoLocatorRepository,
  })  : _favoriteRepository = favoriteRepository,
        _geoLocatorRepository = geoLocatorRepository;

  Future<bool> call(CityLocation cityLocation) async {
    final currentLocation = await _geoLocatorRepository.getCurrentLocation();

    final isAvailableToStore = await _favoriteRepository.isAvailableToStore(
      cityLocation: cityLocation,
      currentLocation: currentLocation,
    );

    return isAvailableToStore;
  }
}
