import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:hive/hive.dart';

part 'city_location_hive_model.g.dart';

@HiveType(typeId: 0)
class CityLocationHiveModel extends HiveObject {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String? cityName;

  @HiveField(3)
  final String timestamp;

  CityLocationHiveModel({
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.timestamp,
  });

  CityLocation toEntity() {
    return CityLocation(
      latitude: latitude,
      longitude: longitude,
      name: cityName,
      timestamp: timestamp,
    );
  }

  factory CityLocationHiveModel.fromEntity(CityLocation location) =>
      CityLocationHiveModel(
        latitude: double.parse(location.latitude.toStringAsFixed(3)),
        longitude: double.parse(location.longitude.toStringAsFixed(3)),
        cityName: location.name,
        timestamp: location.timestamp,
      );
}
