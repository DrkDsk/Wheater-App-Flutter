import 'package:clima_app/features/city/domain/entities/user_location.dart';
import 'package:hive/hive.dart';

part 'location_cache_hive_model.g.dart';

@HiveType(typeId: 1)
class LocationCacheHiveModel extends HiveObject {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String timestamp;

  LocationCacheHiveModel({
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

  factory LocationCacheHiveModel.fromEntity(UserLocation entity) {
    return LocationCacheHiveModel(
      latitude: double.parse(entity.latitude.toStringAsFixed(3)),
      longitude: double.parse(entity.longitude.toStringAsFixed(3)),
      timestamp: entity.timestamp.toIso8601String(),
    );
  }
}
