import 'dart:async';

import 'package:clima_app/core/shared/data/datasources/geo_locator_data_source.dart';
import 'package:flutter/services.dart';

class GeoLocatorDataSourceImpl implements GeoLocatorDataSource {
  static const _locationEventChannel = EventChannel(
    'com.app/location_stream',
  );

  static const _locationChannel = MethodChannel("com.app/location");

  @override
  Future<dynamic> getCurrentLocation() async {
    final result = await _locationChannel.invokeMethod("getCurrentLocation");

    return result;
  }

  @override
  Stream<Map<String, dynamic>> watchPosition() {
    return _locationEventChannel.receiveBroadcastStream().map((event) {
      return Map<String, dynamic>.from(event);
    });
  }

  @override
  Future<bool> requestPermissions() async {
    final result =
        await _locationChannel.invokeMethod<bool>("requestPermission");

    return result ?? false;
  }
}
