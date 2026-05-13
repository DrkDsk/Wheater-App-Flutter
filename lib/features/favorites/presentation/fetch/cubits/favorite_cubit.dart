import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository _repository;

  FavoriteCubit({
    required FavoriteRepository repository,
  })  : _repository = repository,
        super(const FavoriteState());

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
      return state.copyWith(
        status: FavoriteStatus.success,
      );
    });

    emit(newState);
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
