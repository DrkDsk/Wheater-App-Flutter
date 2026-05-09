import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:geocoding/geocoding.dart';

abstract class LocationRepository {
  Future<Coordinate?> getCurrentLocation();

  Future<Placemark?> getLocationInformation({
    required double latitude,
    required double longitude,
  });

  Future<Coordinate> ensureCoordinates({
    double? latitude,
    double? longitude,
  });
}
