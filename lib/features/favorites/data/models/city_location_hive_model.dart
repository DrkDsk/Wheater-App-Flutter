import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'city_location_hive_model.g.dart';

@HiveType(typeId: 0)
class CityLocationHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String city;

  @HiveField(2)
  final double latitude;

  @HiveField(3)
  final double longitude;

  @HiveField(4)
  final String state;

  @HiveField(5)
  final String country;

  @HiveField(6)
  final String cityName;

  CityLocationHiveModel({
    required this.id,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.state,
    required this.country,
    required this.cityName,
  });

  CityLocation toEntity() {
    return CityLocation(
      id: id,
      city: city,
      latitude: latitude,
      longitude: longitude,
      country: country,
      state: state,
      cityName: cityName,
    );
  }

  factory CityLocationHiveModel.fromEntity(CityLocation location) =>
      CityLocationHiveModel(
        id: location.id ?? const Uuid().v4(),
        city: location.city,
        latitude: double.parse(location.latitude.toStringAsFixed(3)),
        longitude: double.parse(location.longitude.toStringAsFixed(3)),
        state: location.state,
        country: location.country,
        cityName: location.cityName,
      );
}
