import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/city/domain/use_cases/is_available_to_store_location_use_case.dart';
import 'package:clima_app/features/city/domain/use_cases/store_location_use_case.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository _repository;
  final StoreLocationUseCase _storeLocationUseCase;
  final IsAvailableToStoreLocationUseCase _availableToStoreLocationUseCase;

  FavoriteCubit({
    required FavoriteRepository repository,
    required StoreLocationUseCase storeLocationUseCase,
    required IsAvailableToStoreLocationUseCase availableToStoreUseCase,
  })  : _repository = repository,
        _storeLocationUseCase = storeLocationUseCase,
        _availableToStoreLocationUseCase = availableToStoreUseCase,
        super(const FavoriteState());

  Future<void> store({required CityLocation cityLocation}) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    final storeResult = await _storeLocationUseCase(
      cityLocation,
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
    final result = await _availableToStoreLocationUseCase(cityLocation);

    emit(state.copyWith(isAvailableToStore: result));
  }
}
