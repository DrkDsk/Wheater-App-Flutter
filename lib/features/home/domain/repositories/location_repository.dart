import 'package:clima_app/features/city/domain/entities/user_location.dart';
import 'package:geocoding/geocoding.dart';

abstract class LocationRepository {
  Stream<UserLocation> watchLocation();

  Future<UserLocation> getCurrentLocation();

  Future<Placemark?> getLocationInformation({
    required double latitude,
    required double longitude,
  });

  Future<void> stopTracking();
}
