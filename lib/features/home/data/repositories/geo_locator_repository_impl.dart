import 'package:clima_app/core/error/exceptions/permission_exception.dart';
import 'package:clima_app/core/shared/data/datasources/geo_locator_data_source.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/home/domain/repositories/geo_locator_repository.dart';
import 'package:geocoding/geocoding.dart';

class GeoLocatorRepositoryImpl implements GeoLocatorRepository {
  final GeoLocatorDataSource _geoLocatorDataSource;

  GeoLocatorRepositoryImpl({
    required GeoLocatorDataSource geoLocatorDataSource,
  }) : _geoLocatorDataSource = geoLocatorDataSource;

  @override
  Future<CityLocation> getCurrentLocation() async {
    final permissions = await _geoLocatorDataSource.requestPermissions();

    if (!permissions) {
      throw const PermissionException(
        channel: "ubicación",
        message: "No se han otorgado los permisos necesarios",
      );
    }

    final locationMap = await _geoLocatorDataSource.getCurrentLocation();

    final latitude = (locationMap["latitude"] as num).toDouble();
    final longitude = (locationMap["longitude"] as num).toDouble();

    return CityLocation(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now().toIso8601String(),
    );
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
  Stream<CityLocation> watchLocation() async* {
    final permissions = await _geoLocatorDataSource.requestPermissions();

    if (!permissions) {
      throw const PermissionException(
        channel: "ubicación",
        message: "No se han otorgado los permisos necesarios",
      );
    }

    await for (final json in _geoLocatorDataSource.watchPosition()) {
      final latitude = (json["latitude"] as num).toDouble();
      final longitude = (json["longitude"] as num).toDouble();

      final cityLocation = CityLocation(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now().toIso8601String(),
      );

      yield cityLocation;
    }
  }
}
