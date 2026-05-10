import 'package:clima_app/features/city/domain/entities/city_location.dart';

class CityLocationModel {
  final double latitude;
  final double longitude;
  final String name;

  const CityLocationModel({
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  factory CityLocationModel.fromMap(Map<String, dynamic> map) {
    final String city = map['name'] as String;
    final String state = map['state'] as String;
    final String cityName = "$city, $state";

    return CityLocationModel(name: cityName, latitude: 0, longitude: 0);
  }

  CityLocation toEntity() {
    return CityLocation(
      name: name,
      lat: latitude,
      long: longitude,
    );
  }
}
