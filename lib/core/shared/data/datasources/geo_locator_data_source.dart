import 'package:clima_app/features/city/domain/entities/city_location.dart';

abstract class GeoLocatorDataSource {
  Future<CityLocation> getCurrentLocation();

  Stream<Map<String, dynamic>> watchPosition();
}
