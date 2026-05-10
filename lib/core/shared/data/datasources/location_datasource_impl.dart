import 'dart:async';

import 'package:clima_app/core/constants/hive_constants.dart';
import 'package:clima_app/core/shared/data/datasources/location_datasource.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class LocationPlatform {
  static const MethodChannel platform = MethodChannel('device/location');
}

class LocationDataSourceImpl implements LocationLocalDatasource {
  final Box<CityLocationHiveModel> _cityLocationCacheBox;

  const LocationDataSourceImpl({
    required Box<CityLocationHiveModel> boxLocation,
  }) : _cityLocationCacheBox = boxLocation;

  @override
  Future<void> cacheLocation(CityLocation location) async {
    final locationHiveModel = CityLocationHiveModel(
      longitude: location.longitude,
      latitude: location.latitude,
      name: location.name,
      timestamp: location.timestamp,
    );

    await _cityLocationCacheBox.put(locationCacheKey, locationHiveModel);
  }

  @override
  Future<CityLocationHiveModel?> getCachedLocation() async {
    final data = _cityLocationCacheBox.get(locationCacheKey);

    if (data == null) return null;

    return data;
  }
}
