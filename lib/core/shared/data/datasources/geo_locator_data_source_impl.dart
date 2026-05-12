import 'dart:async';

import 'package:clima_app/core/shared/data/datasources/geo_locator_data_source.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:flutter/services.dart';

class GeoLocatorDataSourceImpl implements GeoLocatorDataSource {
  static const _locationEventChannel = EventChannel(
    'com.app/location_stream',
  );

  static const _locationChannel = MethodChannel("com.app/location");

  @override
  Future<CityLocation> getCurrentLocation() async {
    final result = await _locationChannel.invokeMethod("getCurrentLocation");

    return CityLocation(
      latitude: (result["latitude"] as num).toDouble(),
      longitude: (result["longitude"] as num).toDouble(),
      timestamp: DateTime.now().toIso8601String(),
    );
  }

  @override
  Stream<Map<String, dynamic>> getLocationStream() {
    return _locationEventChannel.receiveBroadcastStream().map((event) {
      return Map<String, dynamic>.from(event);
    });
  }
}
