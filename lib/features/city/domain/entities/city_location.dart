import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:equatable/equatable.dart';

class CityLocation with EquatableMixin {
  final String? id;
  final String city;
  final double latitude;
  final double longitude;
  final String country;
  final String state;
  final String cityName;

  CityLocation({
    this.id,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    required this.cityName,
  });

  CityLocation copyWith({
    String? id,
    String? city,
    double? latitude,
    double? longitude,
    String? country,
    String? state,
    String? cityName,
  }) {
    return CityLocation(
      id: id ?? this.id,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      country: country ?? this.country,
      state: state ?? this.state,
      cityName: cityName ?? this.cityName,
    );
  }

  Coordinate toCoordinate() {
    return Coordinate(latitude: latitude, longitude: longitude);
  }

  @override
  List<Object?> get props => [
        id,
        city,
        latitude,
        longitude,
        country,
        state,
        cityName,
      ];
}
