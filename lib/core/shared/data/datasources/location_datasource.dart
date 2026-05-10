import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';

abstract class LocationLocalDatasource {
  Future<void> cacheLocation(CityLocation location);

  Future<CityLocationHiveModel?> getCachedLocation();
}
