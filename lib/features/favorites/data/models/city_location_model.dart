import 'package:clima_app/features/city/domain/entities/city_location.dart';

class CityLocationModel {
  final double latitude;
  final double longitude;
  final String name;
  final DateTime timestamp;

  const CityLocationModel({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.timestamp,
  });

  factory CityLocationModel.fromMap(Map<String, dynamic> map) {
    final String city = map['name'] as String;
    final String state = map['state'] as String;
    final String cityName = "$city, $state";

    return CityLocationModel(
      name: cityName,
      latitude: 0,
      longitude: 0,
      timestamp: DateTime.now(),
    );
  }

  CityLocation toEntity() {
    return CityLocation(
      name: name,
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp.toIso8601String(),
    );
  }
}
