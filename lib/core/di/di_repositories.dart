import 'package:clima_app/core/shared/data/datasources/geo_locator_data_source.dart';
import 'package:clima_app/core/shared/data/datasources/weather_description_local_datasource.dart';
import 'package:clima_app/features/city/data/datasources/city_datasource.dart';
import 'package:clima_app/features/city/data/repositories/city_repository_impl.dart';
import 'package:clima_app/features/city/domain/repositories/city_repository.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_datasource.dart';
import 'package:clima_app/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/home/data/datasources/search_weather_datasource.dart';
import 'package:clima_app/features/home/data/repositories/geo_locator_repository_impl.dart';
import 'package:clima_app/features/home/data/repositories/weather_repository_impl.dart';
import 'package:clima_app/features/home/data/repositories/weather_description_repository_impl.dart';
import 'package:clima_app/features/home/domain/repositories/geo_locator_repository.dart';
import 'package:clima_app/features/home/domain/repositories/weather_repository.dart';
import 'package:clima_app/features/home/domain/repositories/weather_description_repository.dart';
import 'package:clima_app/features/ia/data/datasources/ia_datasource.dart';
import 'package:clima_app/features/ia/data/repositories/ia_repository_impl.dart';
import 'package:clima_app/features/ia/domain/repositories/ia_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future registerRepositories() async {
  getIt.registerLazySingleton<IARepository>(
    () => IaRepositoryImpl(datasource: getIt<IADatasource>()),
  );

  getIt.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(dataSource: getIt<CityDataSource>()),
  );

  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      datasource: getIt<SearchWeatherDataSource>(),
    ),
  );

  getIt.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(
      favoriteWeatherDataSource: getIt<FavoriteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<WeatherDescriptionRepository>(
    () => WeatherDescriptionRepositoryImpl(
      dataSource: getIt<WeatherDescriptionLocalDataSourceImpl>(),
    ),
  );

  getIt.registerLazySingleton<GeoLocatorRepository>(
    () => GeoLocatorRepositoryImpl(
      geoLocatorDataSource: getIt<GeoLocatorDataSource>(),
    ),
  );
}
