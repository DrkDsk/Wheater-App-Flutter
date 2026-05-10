import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';

abstract interface class FavoriteWeatherDataSource {
  Future<CityLocationHiveModel?> findByKey({required String key});

  Future<CityLocationHiveModel?> findById({required String? id});

  Future<void> store({required CityLocationHiveModel city});

  Future<List<CityLocationHiveModel>> index();

  Future<bool> delete({required CityLocationHiveModel model});

  Future<void> storeLocationCache({required CityLocation location});
}
