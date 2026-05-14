import 'package:clima_app/core/helpers/network_helper.dart';
import 'package:clima_app/core/shared/ui/cubits/network_cubit.dart';
import 'package:clima_app/features/city/domain/repositories/city_repository.dart';
import 'package:clima_app/features/city/domain/use_cases/is_available_to_store_location_use_case.dart';
import 'package:clima_app/features/city/domain/use_cases/store_location_use_case.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/home/domain/usecases/get_current_location_use_case.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:clima_app/features/ia/domain/repositories/ia_repository.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future registerBlocs() async {
  final getFavoritesLocationUseCase =
      getIt<GetFavoritesAndCurrentLocationUseCase>();

  getIt.registerFactory<NetworkCubit>(
    () => NetworkCubit(networkService: getIt<NetworkHelper>()),
  );

  getIt.registerFactory<IACubit>(
    () => IACubit(repository: getIt<IARepository>()),
  );

  getIt.registerFactory<FavoriteCubit>(
    () => FavoriteCubit(
      repository: getIt<FavoriteRepository>(),
      storeLocationUseCase: getIt<StoreLocationUseCase>(),
      availableToStoreUseCase: getIt<IsAvailableToStoreLocationUseCase>(),
    ),
  );

  getIt.registerFactory<WeatherBloc>(
    () => WeatherBloc(
      getWeatherUseCase: getIt<GetWeatherUseCase>(),
      cityRepository: getIt<CityRepository>(),
    ),
  );

  getIt.registerFactory<HomePageNavigationCubit>(
    () => HomePageNavigationCubit(),
  );

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      getFavoritesLocationUseCase: getFavoritesLocationUseCase,
    ),
  );
}
