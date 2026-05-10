import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:hive/hive.dart';

part 'location_cache_hive_model.g.dart';

@HiveType(typeId: 1)
class LocationCacheHiveModel extends HiveObject {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String city;

  @HiveField(3)
  final String state;

  @HiveField(4)
  final String country;

  @HiveField(5)
  final String cityName;

  LocationCacheHiveModel({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.state,
    required this.country,
    required this.cityName,
  });

  CityLocation toEntity() {
    return CityLocation(
      latitude: latitude,
      longitude: longitude,
      city: city,
      country: country,
      state: state,
      cityName: cityName,
    );
  }

  factory LocationCacheHiveModel.fromEntity(CityLocation entity) {
    return LocationCacheHiveModel(
      latitude: double.parse(entity.latitude.toStringAsFixed(3)),
      longitude: double.parse(entity.longitude.toStringAsFixed(3)),
      city: entity.city,
      state: entity.state,
      country: entity.country,
      cityName: entity.cityName,
    );
  }

  @override
  String get key => city;
}
