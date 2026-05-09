import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class FavoriteRepository {
  Future<Either<Failure, bool>> store({required CityLocation cityLocation});

  Future<Either<Failure, List<CityLocation>>> index();

  Future<Either<Failure, bool>> delete({required CityLocation cityLocation});

  Future<Either<Failure, bool>> isAvailableToStore({
    required CityLocation cityLocation,
  });
}
