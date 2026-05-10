import 'package:clima_app/features/city/domain/entities/user_location.dart';
import 'package:clima_app/features/favorites/data/models/location_cache_hive_model.dart';

abstract class LocationLocalDatasource {
  Future<void> cacheLocation(UserLocation location);

  Future<LocationCacheHiveModel?> getCachedLocation();
}
