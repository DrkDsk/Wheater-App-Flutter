import 'package:clima_app/features/city/domain/entities/user_location.dart';
import 'package:hive/hive.dart';

part 'city_location_hive_model.g.dart';

@HiveType(typeId: 0)
class CityLocationHiveModel extends HiveObject {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String timestamp;

  CityLocationHiveModel({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  UserLocation toEntity() {
    return UserLocation(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.parse(timestamp),
    );
  }

  factory CityLocationHiveModel.fromEntity(UserLocation location) =>
      CityLocationHiveModel(
        latitude: double.parse(location.latitude.toStringAsFixed(3)),
        longitude: double.parse(location.longitude.toStringAsFixed(3)),
        timestamp: location.timestamp.toIso8601String(),
      );
}
