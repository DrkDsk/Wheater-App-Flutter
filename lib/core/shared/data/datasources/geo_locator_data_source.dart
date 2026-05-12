abstract class GeoLocatorDataSource {
  Future<dynamic> getCurrentLocation();

  Stream<Map<String, dynamic>> watchPosition();
}
