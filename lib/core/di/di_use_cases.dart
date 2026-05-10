import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:clima_app/features/home/domain/repositories/search_weather_repository.dart';
import 'package:clima_app/features/home/domain/usecases/get_current_location_use_case.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future registerUseCases() async {
  getIt.registerLazySingleton<GetFavoritesAndCurrentLocationUseCase>(
    () => GetFavoritesAndCurrentLocationUseCase(
      locationRepository: getIt<LocationRepository>(),
      favoriteRepository: getIt<FavoriteRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetWeatherUseCase>(
    () => GetWeatherUseCase(
      searchWeatherRepository: getIt<SearchWeatherRepository>(),
      mapper: getIt<WeatherMapper>(),
      locationRepository: getIt<LocationRepository>(),
    ),
  );
}
