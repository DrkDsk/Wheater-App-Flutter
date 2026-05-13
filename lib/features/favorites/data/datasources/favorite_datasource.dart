import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';

abstract interface class FavoriteDataSource {
  Future<CityLocationHiveModel?> findById({required String? id});

  Future<void> store({required CityLocationHiveModel city});

  Future<List<CityLocationHiveModel>> index();

  Future<bool> delete({required CityLocationHiveModel model});
}
