import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/city/domain/use_cases/is_available_to_store_location_use_case.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:dartz/dartz.dart';

class StoreLocationUseCase {
  final FavoriteRepository _favoriteRepository;
  final IsAvailableToStoreLocationUseCase _isAvailableToStoreLocationUseCase;

  const StoreLocationUseCase({
    required FavoriteRepository favoriteRepository,
    required IsAvailableToStoreLocationUseCase availableToStoreUSeCase,
  })  : _favoriteRepository = favoriteRepository,
        _isAvailableToStoreLocationUseCase = availableToStoreUSeCase;

  Future<Either<Failure, CityLocation>> call(CityLocation cityLocation) async {
    try {
      final isAvailableToStore =
          await _isAvailableToStoreLocationUseCase(cityLocation);

      if (isAvailableToStore) {
        await _favoriteRepository.store(cityLocation: cityLocation);
      }

      return Right(cityLocation);
    } catch (e) {
      return Left(UnexpectedFailure(
        "Ocurrió un error al guardar la ubicación",
      ));
    }
  }
}
