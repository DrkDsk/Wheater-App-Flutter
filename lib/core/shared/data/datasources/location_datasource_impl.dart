import 'dart:async';

import 'package:clima_app/core/constants/hive_constants.dart';
import 'package:clima_app/core/shared/data/datasources/location_datasource.dart';
import 'package:clima_app/features/city/domain/entities/user_location.dart';
import 'package:clima_app/features/favorites/data/models/location_cache_hive_model.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class LocationPlatform {
  static const MethodChannel platform = MethodChannel('device/location');
}

class LocationDataSourceImpl implements LocationLocalDatasource {
  final Box<LocationCacheHiveModel> _locationCacheBox;

  const LocationDataSourceImpl(
      {required Box<LocationCacheHiveModel> boxLocation})
      : _locationCacheBox = boxLocation;

  @override
  Future<void> cacheLocation(UserLocation location) async {
    final locationHiveModel = LocationCacheHiveModel(
      timestamp: location.timestamp.toIso8601String(),
      longitude: location.longitude,
      latitude: location.latitude,
    );

    await _locationCacheBox.put(locationCacheKey, locationHiveModel);
  }

  @override
  Future<LocationCacheHiveModel?> getCachedLocation() async {
    final data = _locationCacheBox.get(locationCacheKey);

    print("data: $data");

    if (data == null) return null;

    return data;
  }
}
