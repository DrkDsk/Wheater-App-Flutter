import 'package:clima_app/features/city/domain/entities/user_location.dart';

class CityLocation {
  final String name;
  final double lat;
  final double long;

  const CityLocation(
      {required this.name, required this.lat, required this.long});

  CityLocation copyWith({
    String? name,
    double? lat,
    double? long,
  }) {
    return CityLocation(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  UserLocation toUserLocation() {
    return UserLocation(
      latitude: lat,
      longitude: long,
      timestamp: DateTime.now(),
    );
  }
}
