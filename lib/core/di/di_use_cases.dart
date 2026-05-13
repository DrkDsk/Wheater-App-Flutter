import 'package:clima_app/features/city/domain/use_cases/is_available_to_store_location_use_case.dart';
import 'package:clima_app/features/city/domain/use_cases/store_location_use_case.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/home/domain/repositories/geo_locator_repository.dart';
import 'package:clima_app/features/home/domain/repositories/weather_repository.dart';
import 'package:clima_app/features/home/domain/usecases/get_current_location_use_case.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/home/domain/usecases/observe_location_changes_use_case.dart';
import 'package:clima_app/features/home/presentation/dto/weather_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future registerUseCases() async {
  final geoLocatorRepository = getIt<GeoLocatorRepository>();
  final favoriteRepository = getIt<FavoriteRepository>();

  getIt.registerLazySingleton<ObserveLocationChangesUseCase>(
    () => ObserveLocationChangesUseCase(
      locationRepository: geoLocatorRepository,
    ),
  );

  getIt.registerLazySingleton<IsAvailableToStoreLocationUseCase>(
    () => IsAvailableToStoreLocationUseCase(
        favoriteRepository: favoriteRepository,
        geoLocatorRepository: geoLocatorRepository),
  );

  getIt.registerLazySingleton<StoreLocationUseCase>(
    () => StoreLocationUseCase(
      favoriteRepository: favoriteRepository,
      availableToStoreUSeCase: getIt<IsAvailableToStoreLocationUseCase>(),
    ),
  );

  getIt.registerLazySingleton<GetFavoritesAndCurrentLocationUseCase>(
    () => GetFavoritesAndCurrentLocationUseCase(
      geoLocatorRepository: geoLocatorRepository,
      favoriteRepository: getIt<FavoriteRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetWeatherUseCase>(
    () => GetWeatherUseCase(
      searchWeatherRepository: getIt<WeatherRepository>(),
      mapper: getIt<WeatherMapper>(),
      locationRepository: geoLocatorRepository,
    ),
  );
}
