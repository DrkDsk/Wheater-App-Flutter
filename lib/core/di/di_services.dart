import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/services/favorite_service.dart';
import 'package:clima_app/features/home/domain/repositories/weather_description_repository.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future registerServices() async {
  getIt.registerLazySingleton<LocationMapper>(
    () => LocationMapper(
      favoriteDataSource: getIt<FavoriteWeatherDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
    () => WeatherMapper(
      repository: getIt<WeatherDescriptionRepository>(),
    ),
  );
}
