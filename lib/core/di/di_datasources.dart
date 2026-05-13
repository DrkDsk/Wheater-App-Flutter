import 'package:clima_app/core/dio_client.dart';
import 'package:clima_app/core/shared/data/datasources/geo_locator_data_source.dart';
import 'package:clima_app/core/shared/data/datasources/geo_locator_data_source_impl.dart';
import 'package:clima_app/core/shared/data/datasources/weather_description_local_datasource.dart';
import 'package:clima_app/features/city/data/datasources/city_datasource.dart';
import 'package:clima_app/features/city/data/datasources/city_datasource_impl.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_datasource.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_datasource_impl.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource_impl.dart';
import 'package:clima_app/features/ia/data/datasources/ia_datasource.dart';
import 'package:clima_app/features/ia/data/datasources/ia_datasource_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future registerDataSources() async {
  final dioClient = getIt<DioClient>();
  final dio = dioClient.dio;
  final favoriteCityBox = getIt<Box<CityLocationHiveModel>>();

  getIt.registerLazySingleton<IADatasource>(() => IADatasourceImpl());

  getIt.registerLazySingleton<CityDataSource>(
    () => CityDataSourceImpl(dio: dio),
  );

  getIt.registerLazySingleton<SearchWeatherDataSource>(
    () => SearchWeatherDatasourceImpl(dio: dio),
  );

  getIt.registerLazySingleton<WeatherDescriptionLocalDataSourceImpl>(
    () => WeatherDescriptionLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<FavoriteDataSource>(
    () => FavoriteDataSourceImpl(
      favoriteCityBox: favoriteCityBox,
    ),
  );

  getIt.registerLazySingleton<GeoLocatorDataSource>(
    () => GeoLocatorDataSourceImpl(),
  );
}
