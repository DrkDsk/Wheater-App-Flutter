import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationPlatform {
  static const MethodChannel platform = MethodChannel('device/location');
}

class LocationDataSourceImpl {
  const LocationDataSourceImpl();

  Future<LocationData> getCurrentLocation() async {
    final location = Location();
    
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) throw Exception("No se puede obtener la ubicación");
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception("No se puede obtener la ubicación");
      }
    }

    LocationData position = await location.getLocation();

    return position;
  }
}
