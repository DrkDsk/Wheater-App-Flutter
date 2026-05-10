import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:geocoding/geocoding.dart';

abstract class LocationRepository {
  Future<CityLocation> getCurrentLocation();

  Future<Placemark?> getLocationInformation({
    required double latitude,
    required double longitude,
  });

  Future<Coordinate> ensureCoordinates({
    double? latitude,
    double? longitude,
  });
}
