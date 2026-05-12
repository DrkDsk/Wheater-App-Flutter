abstract class GeoLocatorDataSource {
  Future<Map<String, dynamic>> getCurrentLocation();

  Stream<Map<String, dynamic>> watchPosition();
}
