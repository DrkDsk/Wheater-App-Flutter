import 'package:clima_app/features/city/domain/entities/user_location.dart';

class CityLocation {
  final String? name;
  final double latitude;
  final double longitude;

  const CityLocation({
    this.name,
    required this.latitude,
    required this.longitude,
  });

  UserLocation toUserLocation() {
    return UserLocation(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
    );
  }

  CityLocation copyWith({
    String? name,
    double? latitude,
    double? longitude,
  }) {
    return CityLocation(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
