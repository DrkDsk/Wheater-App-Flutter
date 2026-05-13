import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:dartz/dartz.dart';

class StoreLocationUseCase {
  final LocationRepository _locationRepository;

  const StoreLocationUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  Future<Either<Failure, CityLocation>> call(CityLocation location) async {
    try {
      await _locationRepository.store(location);

      return Right(location);
    } catch (e) {
      return Left(UnexpectedFailure(
        "Ocurrió un error al guardar la ubicación",
      ));
    }
  }
}
