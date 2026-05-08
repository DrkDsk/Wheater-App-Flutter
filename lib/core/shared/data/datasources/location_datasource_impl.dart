
import 'package:clima_app/core/helpers/network_helper.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationPlatform {
  static const MethodChannel platform = MethodChannel('device/location');
}

class LocationDataSourceImpl {
  final NetworkHelper _networkHelper;

  const LocationDataSourceImpl({required NetworkHelper networkHelper})
      : _networkHelper = networkHelper;

  Future<LocationData?> getCurrentLocation() async {
    await _networkHelper.checkConnection();

    final location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return null;
    }

    LocationData position = await location.getLocation();

    return position;
  }
}
