import 'package:clima_app/core/shared/data/datasources/geo_locator_data_source.dart';
import 'package:clima_app/core/shared/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/city/domain/entities/user_location.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:geocoding/geocoding.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSourceImpl _locationDataSource;
  final GeoLocatorDataSource _geoLocatorDataSource;

  LocationRepositoryImpl({
    required LocationDataSourceImpl locationDataSource,
    required GeoLocatorDataSource geoLocatorDataSource,
  })  : _locationDataSource = locationDataSource,
        _geoLocatorDataSource = geoLocatorDataSource;

  @override
  Future<UserLocation> getCurrentLocation() async {
    final storedLocationModel = await _locationDataSource.getCachedLocation();

    final position = storedLocationModel?.toEntity();

    if (position == null) {
      final currentLocation = await _geoLocatorDataSource.getCurrentLocation();
      return UserLocation(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        timestamp: currentLocation.timestamp,
      );
    }

    return position;
  }

  @override
  Future<Placemark?> getLocationInformation({
    required double latitude,
    required double longitude,
  }) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    return placemarks.isEmpty ? null : placemarks.first;
  }

  @override
  Future<void> stopTracking() {
    return _geoLocatorDataSource.stopTracking();
  }

  @override
  Stream<UserLocation> watchLocation() async* {
    await for (final location in _geoLocatorDataSource.watchPosition()) {
      await _locationDataSource.cacheLocation(location);

      yield location;
    }
  }
}
