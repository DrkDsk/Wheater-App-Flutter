import 'package:clima_app/features/city/domain/entities/user_location.dart';

class UserLocationModel {
  final double lat;
  final double lon;
  final DateTime timestamp;

  const UserLocationModel({
    required this.lat,
    required this.lon,
    required this.timestamp,
  });

  UserLocation toEntity() {
    return UserLocation(
      latitude: lat,
      longitude: lon,
      timestamp: timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory UserLocationModel.fromJson(Map<String, dynamic> map) {
    return UserLocationModel(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }
}
