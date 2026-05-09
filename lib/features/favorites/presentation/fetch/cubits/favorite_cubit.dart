import 'package:bloc/bloc.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:uuid/uuid.dart';

import './favorite_fetch_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository _repository;

  FavoriteCubit({
    required FavoriteRepository repository,
  })  : _repository = repository,
        super(const FavoriteState());

  Future<void> getFavoriteCities() async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final favoritesResult = await _repository.index();

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

    final location = cityLocation.copyWith(id: const Uuid().v4());
    final storeResult = await _repository.store(cityLocation: location);

    final newState = storeResult.fold((error) {
      return state.copyWith(
        message: error.message,
        status: FavoriteStatus.failure,
      );
    }, (result) {
      if (result) {
        state.cities.add(location);
      }

      return state.copyWith(status: FavoriteStatus.success);
    });

    emit(newState);
  }

  Future<void> delete({required CityLocation cityLocation}) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final deleteEither = await _repository.delete(cityLocation: cityLocation);

    final newState = deleteEither.fold((left) {
      return state.copyWith(
        status: FavoriteStatus.failure,
        message: left.message,
      );
    }, (result) {
      state.cities.removeWhere((element) => element.id == cityLocation.id);

      return state.copyWith(
        status: FavoriteStatus.success,
      );
    });

    emit(newState);
  }

  Future<void> compareFavorites() async {
    final currentCitiesInState = state.cities;

    final storedCitiesResult = await _repository.index();

    storedCitiesResult.fold((left) {}, (result) {
      final citiesStateSet =
          currentCitiesInState.map((element) => element.id).toSet();
      final resultSet = result.map((element) => element.id).toSet();

      final areAllInResult = resultSet.containsAll(
        currentCitiesInState.map((cityState) => cityState.id),
      );

      final areAllInState = citiesStateSet.containsAll(
        result.map((e) => e.id),
      );

      if (areAllInState && areAllInResult) {
        return;
      }

      final newState = state.copyWith(cities: result);

      emit(newState);
    });
  }

  Future<void> getCityIsAvailableToSave(
      {required CityLocation cityLocation}) async {
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
