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

  CityLocationHiveModel({
    required this.latitude,
    required this.longitude,
    required this.cityName,
  });

  CityLocation toEntity() {
    return CityLocation(
      latitude: latitude,
      longitude: longitude,
      name: cityName,
    );
  }

  factory CityLocationHiveModel.fromEntity(CityLocation location) =>
      CityLocationHiveModel(
        latitude: double.parse(location.latitude.toStringAsFixed(3)),
        longitude: double.parse(location.longitude.toStringAsFixed(3)),
        cityName: location.name,
      );
}
