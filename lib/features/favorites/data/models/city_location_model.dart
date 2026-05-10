import 'package:clima_app/features/city/domain/entities/city_location.dart';

class CityLocationModel {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String? state;
  final String? cityName;

  const CityLocationModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
    required this.cityName,
  });

  CityLocation toEntity() {
    return CityLocation(
      city: name,
      latitude: lat,
      longitude: lon,
      country: country,
      state: state ?? "",
      cityName: cityName ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
      'cityName': cityName
    };
  }

  factory CityLocationModel.fromJson(Map<String, dynamic> map) {
    final String city = map['name'] as String;
    final String state = map['state'] as String;
    final String cityName = "$city, $state";

    return CityLocationModel(
      name: city,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      country: map['country'] as String,
      state: state,
      cityName: cityName,
    );
  }
}
