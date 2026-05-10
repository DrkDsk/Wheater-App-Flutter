import 'package:bloc/bloc.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/home/domain/usecases/get_current_location_use_case.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository _repository;
  final GetFavoritesAndCurrentLocationUseCase _favoritesCitiesUseCase;

  FavoriteCubit({
    required FavoriteRepository repository,
    required GetFavoritesAndCurrentLocationUseCase favoritesUseCase,
  })  : _repository = repository,
        _favoritesCitiesUseCase = favoritesUseCase,
        super(const FavoriteState());

  Future<void> getFavoriteCities() async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final favoritesResult = await _favoritesCitiesUseCase();

    final newState = favoritesResult.fold((error) {
      return state.copyWith(
        message: error.message,
        status: FavoriteStatus.failure,
      );
    }, (result) {
      return state.copyWith(
        cities: result,
        status: FavoriteStatus.success,
      );
    });

    emit(newState);
  }

  Future<void> store({required CityLocation cityLocation}) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final userLocation = cityLocation;

    final storeResult = await _repository.store(
      cityLocation: userLocation,
    );

    final newState = storeResult.fold((error) {
      return state.copyWith(
        message: error.message,
        status: FavoriteStatus.failure,
      );
    }, (result) {
      if (result) {
        state.cities.add(userLocation);
      }

      return state.copyWith(status: FavoriteStatus.success);
    });

    emit(newState);
  }

  Future<void> delete({required CityLocation cityLocation}) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    /*final deleteEither = await _repository.delete(cityLocation: cityLocation);

    final newState = deleteEither.fold((left) {
      return state.copyWith(
        status: FavoriteStatus.failure,
        message: left.message,
      );
    }, (result) {
      state.cities.removeWhere(
        (element) => element.timestamp == cityLocation.timestamp,
      );

      return state.copyWith(
        status: FavoriteStatus.success,
      );
    });

    emit(newState);*/
  }

  Future<void> compareFavorites() async {
    final currentCitiesInState = state.cities;

    final storedCitiesResult = await _repository.index();

    /*storedCitiesResult.fold((left) {}, (result) {
      final citiesStateSet =
          currentCitiesInState.map((element) => element.timestamp).toSet();
      final resultSet = result.map((element) => element.timestamp).toSet();

      final areAllInResult = resultSet.containsAll(
        currentCitiesInState.map((cityState) => cityState.timestamp),
      );

      final areAllInState = citiesStateSet.containsAll(
        result.map((e) => e.timestamp),
      );

      if (areAllInState && areAllInResult) {
        return;
      }

      final newState = state.copyWith(cities: result);

      emit(newState);
    });*/
  }

  Future<void> getCityIsAvailableToSave({
    required CityLocation cityLocation,
  }) async {
    final resultEither = await _repository.isAvailableToStore(
      cityLocation: cityLocation,
    );

    resultEither.fold((left) {
      emit(state.copyWith(
        isAvailableToStore: false,
        message: left.message,
      ));
    }, (result) {
      emit(state.copyWith(isAvailableToStore: result));
    });
  }
}
