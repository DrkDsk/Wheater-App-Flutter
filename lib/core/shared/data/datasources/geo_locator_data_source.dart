abstract class GeoLocatorDataSource {
  Future<bool> requestPermissions();

  Future<dynamic> getCurrentLocation();

  Stream<Map<String, dynamic>> watchPosition();
}
