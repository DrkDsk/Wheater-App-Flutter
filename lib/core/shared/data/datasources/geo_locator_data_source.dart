import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeoLocatorDataSource {
  Stream<CityLocation> watchPosition();

  Future<void> stopTracking();

  Future<Position> getCurrentLocation();
}
