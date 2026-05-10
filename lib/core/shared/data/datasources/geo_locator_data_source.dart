import 'package:clima_app/features/city/domain/entities/user_location.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeoLocatorDataSource {
  Stream<UserLocation> watchPosition();

  Future<void> stopTracking();

  Future<Position> getCurrentLocation();
}
