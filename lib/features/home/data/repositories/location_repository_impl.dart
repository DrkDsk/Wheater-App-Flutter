import 'package:clima_app/core/extensions/location/location_data_extension.dart';
import 'package:clima_app/core/shared/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:geocoding/geocoding.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSourceImpl _locationDataSource;
  final FavoriteWeatherDataSource _favoriteWeatherDataSource;

  LocationRepositoryImpl(
      {required LocationDataSourceImpl locationDataSource,
      required FavoriteWeatherDataSource favoriteWeatherDataSource})
      : _locationDataSource = locationDataSource,
        _favoriteWeatherDataSource = favoriteWeatherDataSource;

  @override
  Future<CityLocation> getCurrentLocation() async {
    final storedLocationModel =
        await _favoriteWeatherDataSource.getCoordinateCache();

    final position = storedLocationModel?.toEntity();

    if (position == null) {
      final currentLocation = await _locationDataSource.getCurrentLocation();
      return currentLocation.toCityLocation();
    }

    return position;
  }

  @override
  Future<Placemark?> getLocationInformation(
      {required double latitude, required double longitude}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    return placemarks.isEmpty ? null : placemarks.first;
  }
}
