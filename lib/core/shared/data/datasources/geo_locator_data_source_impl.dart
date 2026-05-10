import 'dart:async';

import 'package:clima_app/core/shared/data/datasources/geo_locator_data_source.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorDataSourceImpl implements GeoLocatorDataSource {
  StreamSubscription<CityLocation>? _subscription;

  @override
  Future<void> stopTracking() async {
    await _subscription?.cancel();
  }

  @override
  Stream<CityLocation> watchPosition() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 20,
      ),
    ).map(
      (position) => CityLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        /*timestamp: position.timestamp,*/
      ),
    );
  }

  @override
  Future<Position> getCurrentLocation() async {
    var permissionEnabled = await Geolocator.checkPermission();

    if (permissionEnabled == LocationPermission.denied) {
      permissionEnabled = await Geolocator.requestPermission();
      if (permissionEnabled == LocationPermission.denied ||
          permissionEnabled == LocationPermission.deniedForever) {
        throw Exception("No se puede obtener la ubicación");
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
