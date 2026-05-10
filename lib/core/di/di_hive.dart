import 'package:clima_app/core/helpers/hive_initializer.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future initHive() async {
  await HiveInitializer.init();
  final favoriteCityBox = await HiveInitializer.getFavoritesCitiesBox();

  getIt.registerSingleton<Box<CityLocationHiveModel>>(favoriteCityBox);
}
