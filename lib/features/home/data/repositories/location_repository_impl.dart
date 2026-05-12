import 'package:clima_app/core/shared/data/datasources/geo_locator_data_source.dart';
import 'package:clima_app/core/shared/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
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
  Future<CityLocation> getCurrentLocation() async {
    final storedLocationModel = await _locationDataSource.getCachedLocation();

    final cityLocation = storedLocationModel?.toEntity();

    if (cityLocation == null) {
      final currentLocation = await _geoLocatorDataSource.getCurrentLocation();
      final locationInfo = await getLocationInformation(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      );

      final cityInfo =
          "${locationInfo?.name} ${locationInfo?.administrativeArea}";

      return CityLocation(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        timestamp: currentLocation.timestamp.toIso8601String(),
        name: cityInfo,
      );
    }

    return cityLocation;
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
  Stream<CityLocation> watchLocation() {
    return _geoLocatorDataSource.getLocationStream().map((json) {
      return CityLocation(
        latitude: json['latitude'],
        longitude: json['longitude'],
        timestamp: DateTime.now().toIso8601String(),
      );
    });
  }

  @override
  Future<CityLocation> store(CityLocation location) async {
    final _ = await _locationDataSource.cacheLocation(location);

    return location;
  }
}
