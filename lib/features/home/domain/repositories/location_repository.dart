import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:geocoding/geocoding.dart';

abstract class LocationRepository {
  Future<CityLocation> store(CityLocation location);

  Stream<CityLocation> watchLocation();

  Future<void> stopTracking();

  Future<CityLocation> getCurrentLocation();

  Future<Placemark?> getLocationInformation({
    required double latitude,
    required double longitude,
  });
}
