import 'package:clima_app/core/constants/hive_constants.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_datasource.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:hive/hive.dart';

class FavoriteDataSourceImpl implements FavoriteDataSource {
  final Box<CityLocationHiveModel> favoriteCityBox;

  FavoriteDataSourceImpl({
    required this.favoriteCityBox,
  });

  @override
  Future<void> store({required CityLocationHiveModel city}) async {
    try {
      await favoriteCityBox.put(city.timestamp, city);
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<List<CityLocationHiveModel>> index() async {
    return favoriteCityBox.values.toList();
  }

  @override
  Future<bool> delete({required CityLocationHiveModel model}) async {
    try {
      await model.delete();
      return true;
    } on StateError catch (_) {
      return false;
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<void> storeLocationCache({required CityLocation location}) async {
    try {
      final locationHiveModel = CityLocationHiveModel.fromEntity(location);
      return favoriteCityBox.put(locationCacheKey, locationHiveModel);
    } catch (e) {
      return;
    }
  }

  @override
  Future<CityLocationHiveModel?> findByKey({required String key}) async {
    final result = favoriteCityBox.values
        .where((element) => element.timestamp == key)
        .firstOrNull;

    return result;
  }

  @override
  Future<CityLocationHiveModel?> findById({required String? id}) async {
    if (id == null) return null;

    return favoriteCityBox.get(id);
  }
}
